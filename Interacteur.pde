/**
 * Les interacteurs sont des acteurs non-joueurs pouvant interagir
 * avec les autres interacteurs et les joueurs. Ils ne peuvent
 * cependant pas interagir avec les objets.
 */
abstract class Interacteur extends Acteur {
  /**
   * Constructeur simple.
   * @param _nom Nom de l'interacteur.
   */
  Interacteur(String _nom) {
    super(_nom);
  }

  /**
   * Constructeur complet.
   * @param _nom Nom de l'interacteur.
   * @param _cx Coefficient de vitesse x.
   * @param _cy Coefficient de vitesse y.
   */
  Interacteur(String _nom, float _cx, float _cy) {
    super(_nom, _cx, _cy);
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) {
    return persistant || (_x1 - _x2 <= x && x <= _x1 + 2 * _x2 && _y1 - _y2 <= y && y <= _y1 + 2 * _y2);
  }

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//
  
  /**
   * Événement de ramassage d'un objet.
   * @param _objet Objet ramassé.
   */
  void EvenementRamasser(Objet _objet) {}

  /**
   * Événement de controles.
   */
  final void EvenementControles() {}
}