/**
 * Niveau.
 */
abstract class Niveau extends Ecran {
  /**
   * Liste des couches de niveau.
   */
  ArrayList<CoucheNiveau> couches;

  /**
   * Liste des numéros d'identification des couches.
   */
  HashMap<String, Integer> couches_id;

  /**
   * Cadre d'affichage du niveau.
   */
  CadreAffichage cadre;

  /**
   * Le niveau est-il terminé ?
   */
  boolean terminer;

  /**
   * Constructeur complet.
   * @param _largeur Largeur du niveau.
   * @param _hauteur Hauteur du niveau.
   */
  Niveau(float _largeur, float _hauteur) {
    super(_largeur, _hauteur);
    couches = new ArrayList<CoucheNiveau>();
    couches_id = new HashMap<String, Integer>();
    cadre = new CadreAffichage(_largeur, _hauteur);
  }

  /**
   * Définir le cadre d'affichage.
   * @param _x Coordonnée x du cadre d'affichage.
   * @param _y Coordonnée y du cadre d'affichage.
   * @param _largeur Largeur du cadre d'affichage.
   * @param _hauteur Hauteur du cadre d'affichage.
   */
  void definirCadreAffichage(float _x, float _y, float _largeur, float _hauteur) {
    cadre.x = _x;
    cadre.y = _y;
    cadre.largeur = _largeur;
    cadre.hauteur = _hauteur;
  }

  /**
   * Ajouter une couche de niveau.
   * @param _nom Nom de la couche de niveau.
   * @param _couche Couche de niveau à ajouter.
   */
  void ajouterCoucheNiveau(String _nom, CoucheNiveau _couche) {
    couches_id.put(_nom, couches.size());
    couches.add(_couche);
  }

  /**
   * Récupérer une couche de niveau.
   * @param _nom Nom de la couche de niveau à récupérer.
   */
  CoucheNiveau recupererCoucheNiveau(String _nom) {
    return couches.get(couches_id.get(_nom));
  }
  
  /**
   * Nettoyer tous les objets éphémères.
   */
  void nettoyer() {
    /* Pour chaque couche. */
    for (CoucheNiveau couche: couches) {
      couche.nettoyer();
    }
  }
  
  /**
   * Actualiser un joueur.
   * @param _ancienJoueur Ancien joueur à remplacer.
   * @param _nouveauJoueur Nouveau joueur.
   */
  void actualiserJoueur(Joueur _ancienJoueur, Joueur _nouveauJoueur) {
    for(CoucheNiveau couche: couches) {
      couche.actualiserJoueur(_ancienJoueur, _nouveauJoueur);
    }
  }

  /**
   * Terminer le niveau.
   */
  void terminer() {
    definirRemplacable(); // L'écran devient remplaçable.
    terminer = true;
  }

  /**
   * Fin du niveau.
   */
  void fin() {
    terminer();
  }

  /**
   * Affichage du niveau.
   */
  void draw() {
    translate(-cadre.x, -cadre.y);
    for (CoucheNiveau couche: couches) {
      couche.draw();
    }
  }
  
  /**
   * Récupérer le nombre d'acteurs du niveau.
   * @return Nombre d'acteurs du niveau.
   */
  int recupererNombreActeurs() {
    int compteur = 0;
    for(CoucheNiveau couche: couches) {
      compteur += couche.recupererNombreActeurs();
    }
    return compteur;
  }

  /** 
   * Afficher les élements de fond.
   */
  void afficherFond(boolean _b)  {
    for (CoucheNiveau couche: couches) {
      couche.afficherFond = _b;
    }
  }
  
  /**
   * Afficher les limites.
   */
  void afficherLimites(boolean _b) {
    for (CoucheNiveau couche: couches) { 
      couche.afficherLimites = _b;
    }
  }

  /**
   * Afficher les objets.
   */
  void afficherObjets(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherObjets = _b;
    }
  }

  /**
   * Afficher les autocollants.
   */
  void afficherAutocollants(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherAutocollants = _b;
    }
  }

  /**
   * Afficher les interacteurs.
   */
  void afficherInteracteurs(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherInteracteurs = _b;
    }
  }

  /**
   * Afficher les joueurs.
   */
  void afficherJoueurs(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherJoueurs = _b;
    }
  }

  /**
   * Afficher les éléments de premier plan.
   */
  void afficherPremierPlan(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherPremierPlan = _b;
    }
  }

  /**
   * Afficher les déclencheurs.
   */
  void afficherDeclencheurs(boolean _b) {
    for (CoucheNiveau couche: couches) {
      couche.afficherDeclencheurs = _b;
    }
  }

  //--------------------------//
  //        CONTROLES.        //
  //--------------------------//
  
  void keyPressed(char _touche, int _codeTouche) {
    for (CoucheNiveau couche: couches) { couche.keyPressed(_touche, _codeTouche); }
  }

  void keyReleased(char _touche, int _codeTouche) {
    for (CoucheNiveau couche: couches) { couche.keyReleased(_touche, _codeTouche); }
  }

  void mouseMoved(int _mouseX, int _mouseY) {
    for (CoucheNiveau couche: couches) { couche.mouseMoved(_mouseX, _mouseY); }
  }

  void mousePressed(int _mouseX, int _mouseY, int _bouton) {
    for (CoucheNiveau couche: couches) { couche.mousePressed(_mouseX, _mouseY, _bouton); }
  }

  void mouseDragged(int _mouseX, int _mouseY, int _bouton) {
    for (CoucheNiveau couche: couches) { couche.mouseDragged(_mouseX, _mouseY, _bouton); }
  }

  void mouseReleased(int _mouseX, int _mouseY, int _bouton) {
    for (CoucheNiveau couche: couches) { couche.mouseReleased(_mouseX, _mouseY, _bouton); }
  }

  void mouseClicked(int _mouseX, int _mouseY, int _bouton) {
    for (CoucheNiveau couche: couches) { couche.mouseClicked(_mouseX, _mouseY, _bouton); }
  }
}
