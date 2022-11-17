import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor Token {
    var owner : Principal = Principal.fromText("nckdq-uwcvi-w4kdg-wdoq5-npzs4-scxge-mp4vj-4ld2e-nhx5o-eixf4-fqe");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DKOSE";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

    balances.put(owner, totalSupply); //this gives all the minted tokens to owner

    // solving the balance left in the token amount
    public query func balanceOf(who : Principal) : async Nat {

        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };
        return balance;
    };

    // export this to show my token symbol on the front end
    public query func getSymbol() : async Text {
        return symbol;
    };

    // use the shared keyword to pass a message or token from person to person
    // function to allow another account to receive tokens
    public shared (msg) func payOut() : async Text {
        // Debug.print(debug_show (msg.caller));

        if (balances.get(msg.caller) == null) {
            let amount = 1000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Alreay claimed your tokens";
        };
    };

    // function to allow transfer of an amount from the sender to the recipient
    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
        let fromBalance = await balanceOf(msg.caller);
        // math calc to figure out the amount
        if (fromBalance > amount) {
            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);
            return "Success";
        } else {
            return "Insufficient Funds";
        };
    };
};
