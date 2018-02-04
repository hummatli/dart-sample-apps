part of mud;

class Bear extends Encounter with RandomDamage {

  Bear() : super._();

  whenEncounter() {
    return "grr grow, you encountered a bear!";
  }

}
