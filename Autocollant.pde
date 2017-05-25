/**
 * Autocollants.
 */
class Autocollant extends Sprite {
  /**
   * Durée de l'autocollant.
   */
  protected int duree;
  
  /**
   * L'autocollant peut-il expirer ?
   */
  boolean expiration;
  
  /**
   * L'autocollant doit-il être supprimé.
   */
  boolean supprimer;
  
  /**
   * Propriétaire de l'autocollant.
   */
  Positionnable proprietaire;
  
  /**
   * Constructeur d'un autocollant sans expiration.
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   */
  Autocollant(String _spritesheet, float _x, float _y) {
    this(_spritesheet, _x, _y, false, -1);
  }

  /**
   * Constructeur d'un autocollant sans expiration.
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _lignes Nombre de lignes du spritesheet.
   * @param _colonnes Nombre de colonnes du spritesheet.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   */
  Autocollant(String _spritesheet, int _lignes, int _colonnes, float _x, float _y) {
    this(_spritesheet, _lignes, _colonnes, _x, _y, false, -1);
  }

  /**
   * Constructeur d'un autocollant avec expiration.
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   * @param _duree Durée de l'autocollant.
   */
  Autocollant(String _spritesheet, float _x, float _y, int _duree) {
    this(_spritesheet, _x, _y, true, _duree);
  }

  /**
   * Constructeur d'un autocollant avec expiration.
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _lignes Nombre de lignes du spritesheet.
   * @param _colonnes Nombre de colonnes du spritesheet.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   * @param _duree Durée de l'autocollant.
   */
  Autocollant(String _spritesheet, int _lignes, int _colonnes, float _x, float _y, int _duree) {
    this(_spritesheet, _lignes, _colonnes, _x, _y, true, _duree);
  }
  
  /**
   * Constructeur complet (1x1).
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   * @param _expiration L'autocollant peut-il expirer ?
   * @param _duree Durée de l'autocollant.
   */
  private Autocollant(String _spritesheet, float _x, float _y, boolean _expiration, int _duree) {
    this(_spritesheet, 1, 1, _x, _y, _expiration, _duree);
  }

  /**
   * Constructeur complet.
   * @param _spritesheet Spritesheet de l'autocollant.
   * @param _lignes Nombre de lignes du spritesheet.
   * @param _colonnes Nombre de colonnes du spritesheet.
   * @param _x Coordonnée x de l'autocollant.
   * @param _y Coordonnée y de l'autocollant.
   * @param _expiration L'autocollant peut-il expirer ?
   * @param _duree Durée de l'autocollant.
   */
  private Autocollant(String _spritesheet, int _lignes, int _colonnes, float _x, float _y, boolean _expiration, int _duree) {
    super(_spritesheet, _lignes, _colonnes);
    
    /* Définition de la position. */
    definirPosition(_x, _y);
  
    /* Définition de la durée. */
    duree = _duree;
    
    /* Définition de l'expiration. */
    expiration = _expiration;
    
    /* Initialisation du propriétaire. */
    proprietaire = null;
    
    /* Si l'autocollant peut expirer, on définit son chemin. */
    if(expiration) { definirChemin(); }
  }

  /**
   * Définir le chemin de l'autocollant avant son expiration.
   */
  void definirChemin() {}
  
  /**
   * Définir le propriétaire de l'autocollant.
   */
  void definirProprietaire(Positionnable _proprietaire) {
    proprietaire = _proprietaire;
  }

  /**
   * Affichage de l'autocollant.
   */
  void draw() { super.draw(); }

  /**
   * Affichage de l'autocollant.
   */
  void draw(float _x, float _y) { super.draw(_x, _y); }

  /**
   * Affichage de l'autocollant.
   */
  void draw(float _x, float _y, float _largeur, float _hauteur) {
    /* Si l'autocollant n'a pas d'expiration ou que sa durée est positive. */
    if(!expiration || duree-- > 0) {
      super.draw(); 
    }
    else {
      /* Suppression de l'autocollant. */
      supprimer = true; 
    }
  }
}
