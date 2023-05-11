import Buffer "mo:base/Buffer";
import Bool "mo:base/Bool";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Time "mo:base/Time";
import Result "mo:base/Result";

actor {

  type Result<Ok, Err> = { #ok : Ok; #err : Err };
  public type Time = Time.Time;
  public type Homework = {
    title : Text;
    description : Text;
    dueDate : Time;
    complete : Bool;
  };

  let homeworkDiary = Buffer.Buffer<Homework>(2);
  let homeworkDiaryPending = Buffer.Buffer<Homework>(2);
  let homeworkDiarySearch = Buffer.Buffer<Homework>(2);

  public func addHomework(homework : Homework) : async Nat {
    homeworkDiary.add(homework);
    return homeworkDiary.size() - 1;
  };

  public query func getHomework(homeworkId : Nat) : async Result<Homework, Text> {
    if (Buffer.isEmpty(homeworkDiary)) {
      return #err("Id invalido");
    } else {
      if (homeworkId < homeworkDiary.size()) {
        let homework : Homework = homeworkDiary.get(homeworkId);
        return #ok(homework);
      } else {
        return #err("Id invalido");
      };
    }

  };

  public func updateHomework(homeworkId : Nat, homework : Homework) : async Result<(), Text> {
    if (Buffer.isEmpty(homeworkDiary)) {
      return #err("Id invalido");
    } else {
      if (homeworkId < homeworkDiary.size()) {
        homeworkDiary.put(homeworkId, homework);
        return #ok();
      } else {
        return #err("Id invalido");
      };
    };
  };

  public func markAComplete(homeworkId : Nat) : async Result<(), Text> {
    if (Buffer.isEmpty(homeworkDiary)) {
      return #err("Id invalido");
    } else {
      if (homeworkId < homeworkDiary.size()) {
        let homework = {
          title = homeworkDiary.get(homeworkId).title;
          description = homeworkDiary.get(homeworkId).description;
          dueDate = homeworkDiary.get(homeworkId).dueDate;
          complete = true;
        };
        homeworkDiary.put(homeworkId, homework);
        return #ok(());
      } else {
        return #err("Id invalido");
      };
    };
  };

  public func deleteHomework(homeworkId : Nat) : async Result<(), Text> {

    if (Buffer.isEmpty(homeworkDiary)) {
      return #err("Id invalido");
    } else {
      if (homeworkId < homeworkDiary.size()) {
        let deleteHomework = homeworkDiary.remove(homeworkId);
        return #ok(());
      } else {
        return #err("Id invalido");
      };
    };
  };

  public query func getAllHomework() : async [Homework] {
    return Buffer.toArray<Homework>(homeworkDiary);
  };

  public query func getPendingHomework() : async [Homework] {
    if (Buffer.isEmpty(homeworkDiaryPending) != true) {
      homeworkDiaryPending.clear();
      for (element in homeworkDiary.vals()) {
        if (element.complete != true) {
          homeworkDiaryPending.add(element);
        };
      };
      return Buffer.toArray<Homework>(homeworkDiaryPending);
    } else {
      for (element in homeworkDiary.vals()) {
        if (element.complete != true) {
          homeworkDiaryPending.add(element);
        };
      };
      return Buffer.toArray<Homework>(homeworkDiaryPending);
    };
  };

  public query func searchHomework(searchTerm : Text) : async [Homework] {
    if (Buffer.isEmpty(homeworkDiarySearch) != true) {
      homeworkDiarySearch.clear();
      for (element in homeworkDiary.vals()) {
        if (searchTerm == element.title) {
          homeworkDiarySearch.add(element);
        } else if (searchTerm == element.description) {
          homeworkDiarySearch.add(element);
        };
      };
      return Buffer.toArray<Homework>(homeworkDiarySearch);
    } else {
      for (element in homeworkDiary.vals()) {
        if (searchTerm == element.title) {
          homeworkDiarySearch.add(element);
        } else if (searchTerm == element.description) {
          homeworkDiarySearch.add(element);
        };
      };
      return Buffer.toArray<Homework>(homeworkDiarySearch);
    };
  };
};