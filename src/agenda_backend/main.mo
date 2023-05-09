import Time "mo:base/Time";

actor {

    type Homework = {
        #titulo : Text;
        #decripcion : Text;
        #completado : Bool;
        #vencimiento : Time.Time;
    };

    // Add a new homework task
    public func addHomework(homework : Homework) : async Nat {

    };
    public func getHomework(id : Nat) : async Result.Result<Homework, Text> {

    };
    public func updateHomework(id : Nat, homework : Homework) : async Result.Result<(), Text> {

    };
    public func markAsCompleted(id : Nat) : async Result.Result<(), Text> {

    };
    public func deleteHomework(id : Nat) : async Result.Result<(), Text> {

    };
    public func getAllHomework() : async Nat {

    };
    public func getPendingHomework(homework : Homework) : async Nat {

    };
    public func searchHomework(homework : Homework) : async Nat {

    };

};
