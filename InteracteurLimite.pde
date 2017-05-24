/**
 * Les interacteurs limités sont des interacteurs avec une ou
 * plusieurs limites associées.
 */
abstract class InteracteurLimite extends Interacteur implements AuditeurCollisionLimite {
  /* Liste des limites de l'interacteur. */
  ArrayList<Limite> limites;

  /**
   * Les limites sont-elles actives ?
   */
  boolean limitation;
  
  /**
   * Constructeur simple.
   * @param _nom Nom de l'interacteur.
   */
  InteracteurLimite(String _nom) {
    this(_nom, 0, 0); 
  }

  /**
   * Constructeur complet.
   * @param _nom Nom de l'interacteur.
   */
  InteracteurLimite(String _nom, float _cx, float _cy) {
    super(_nom, _cx, _cy);
    
    /* Par défaut, les limites sont activées. */
    limitation = true;
    limites = new ArrayList<Limite>();
  }

  /**
   * Ajouter une limite.
   * @param _limite Limite à ajouter.
   */
  void ajouterLimite(Limite _limite) { 
    _limite.definirCoefficientVitesse(cx,cy);
    limites.add(_limite);
  }
  
  /**
   * Ajouter une limite et s'enregistrer comme auditeur de collision de celle ci.
   * @param _limite Limite à ajouter.
   * @param _auditeur Auditeur de collision de la limite.
   */
  void ajouterLimite(Limite _limite, boolean _auditeur) {
    ajouterLimite(_limite);
    _limite.ajouterAuditeur(this);
  }

  /**
   * Définir la limite suivante de l'interacteur.
   * @param _suivant Limite suivante de l'interacteur..
   */
  void definirSuivante(InteracteurLimite _suivante) {
    /* Si l'interacteur est associé à une limite. */
    if (limites.size() == 1) {
      limites.get(0).definirSuivante(_suivante.limites.get(0));
    }
  }

  /**
   * Définir la limite précédente de l'interacteur.
   * @param _precedente Limite précédente de l'interacteur..
   */
  void definirPrecedente(InteracteurLimite _precedente) {
    /* Si l'interacteur est associé à une limite. */
    if(limites.size() == 1) {
      limites.get(0).definirPrecedente(_precedente.limites.get(0));
    }
  }

  /**
   * Activer toutes les limites.
   */
  void activerLimites() {
    limitation = true;
    for (Limite limite : limites) {
      limite.activer();
    }
  }

  /**
   * Désactiver toutes les limites.
   */
  void desactiverLimites() {
    limitation = false;
    for(int i = limites.size() -1; i >= 0; i--) {
      Limite limite = limites.get(i);
      limite.desactiver();
    }
  }
  
  /**
   * Supprimer l'interacteur limité.
   */
  void supprimerActeur() {
    /* Supprimer les limites. */
    desactiverLimites();
    limites = new ArrayList<Limite>();
    super.supprimerActeur();
  }
  
  /**
   * Affichage des limites.
   */
  void afficherLimites(float _x1, float _y1, float _x2, float _y2) {
    for(Limite limite : limites) {
      limite.draw(_x1, _y1, _x2, _y2);
    }
  }
  
  /**
   * Vérifier si quelque chose est attachée à une des limites de l'interacteur.
   */
  boolean verifierPassagers() {
    /* Pas de passagers. */
    return false;
  }

  /**
   * Actualisation d'un interacteur limité.
   */
  void actualiser() {
    super.actualiser();

    /* Calcul du déplacement. */
    float dx = x - precedent.x;
    float dy = y - precedent.y;

    /* Si le déplacement n'est pas nul. */
    if(dx != 0 && dy != 0) {
      /* Pour chaque limite. */
      for(Limite limite: limites) {
        /* Déplacement de la limite. */
        limite.ajouterPosition(dx, dy);
      }
    }
  }

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//

  /**
   * Événement de collision.
   * @param _limite Limite de la collision.
   * @param _acteur Acteur de la collision.
   * @param _intersection Tableau d'informations d'intersection.
   */
  abstract void EvenementCollision(Limite _limite, Acteur _acteur, float[] _intersection);
}