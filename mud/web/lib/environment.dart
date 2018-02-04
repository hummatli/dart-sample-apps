part of mud;

class Environment {

  String _name;

  Encounter encounter;

  Environment(name) {
    this.name = name;
    this.encounter = new Encounter({});
  }

  String stumbleUpon() {
    this.encounter = new Encounter({"number": 7, "damage": 3});

    var done_damage = this.encounter?.damage_value;
    var interaction = "${_name} You just stumbled upon ... ${this.encounter?.whenEncounter()}";
    if (done_damage > 0) {
     interaction += "<br /> You have ${done_damage} damage!";
   }
   return interaction;
  }

  get damage => encounter.damage_value;

  set name(name) {
    this._name = "[${name}]";
  }

  get name => this._name;

}
