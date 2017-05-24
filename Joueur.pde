/**
 * Les joueurs sont des acteurs contrôlables.
 */
abstract class Joueur extends Acteur {

  /**
   * Construteur simple.
   * @param _nom Nom du joueur.
   */
  Joueur(String _nom) { 
    super(_nom);
  }

  /**
   * Constructeur comptet.
   * @param _nom Nom du joueur.
   * @param _cx Coefficient de vitesse x.
   * @param _cy Coefficient de vitesse y.
   */
  Joueur(String _nom, float _cx, float _cy) {
    super(_nom, _cx, _cy);
  }
}