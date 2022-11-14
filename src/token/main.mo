import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor Token {
    var owner : Principal = Principal.fromText("nckdq-uwcvi-w4kdg-wdoq5-npzs4-scxge-mp4vj-4ld2e-nhx5o-eixf4-fqe");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DKOSE";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

    balances.put(owner, totalSupply); //this gives all the minted tokens to owner

    public query func balanceOf(who : Principal) : async Nat {

        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };
        return balance;
    };
};
