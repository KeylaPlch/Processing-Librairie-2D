/**
 * Les sprites sont des images animées fixes en deux dimensions,
 * avec des images séparées pour chaque trame d'animation.
 */
class Sprite extends Positionnable {
  /**
   * État de la sprite.
   */
  Etat etat;

  /**
   * Chemin de la sprite.
   */
  SpriteChemin chemin;

  /**
   * Alignement de l'acteur.
   */
  float alignementH, alignementV;

  /**
   * Demi-largeur de la sprite.
   */
  float demiLargeur;

  /**
   * Demi-hauteur de la sprite.
   */
  float demiHauteur;

  /**
   * Ancrage de la sprite.
   * Lorsque l'on passe du sprite A à une sprite B, les coordonnées d'ancrage
   * de la sprite A s'alignent avec les coordonnées d'ancrage de B.
   */
  float ancrageH, ancrageV;

  /**
   * Tableau des trames de la sprite.
   */
  PImage[] trames;

  /**
   * Nombre de trames de la sprite.
   */
  int nombreTrames;

  /**
   * Facteur de vitesse d'animation de la sprite.
   */
  float facteurTrame;
  
  /* 
   * Rotation horizontale. 
   */
  boolean rotationHorizontale;

  /* 
   * Rotation verticale. 
   */
  boolean rotationVerticale;

  /**
   * La sprite est-elle visible ?
   */
  boolean visible;
  
  /**
   * La sprite est-elle en animation ?
   */
  boolean animation;

  /**
   * Trame actuelle de l'animation.
   */
  private int trameActuelle;

  /**
   * Décalage de trame.
   */
  int decalageTrame;
  
  /**
   * Compteur de trames de la sprite.
   */
  int compteurTrames;

  /**
   * Constructeur simple.
   * @param _sprite Chemin d'accès au fichier de la sprite.
   */
  Sprite(String _sprite) {
    this(_sprite, 1, 1, 0, 0);
  }

  /**
   * Constructeur simple.
   * @param _sprite Chemin d'accès au fichier de la sprite.
   * @param _lignes Nombre de lignes de la sprite.
   * @param _colonnes Nombre de colonnes de la sprite.
   */
  Sprite(String _sprite, int _lignes, int _colonnes) {
    this(_sprite, _lignes, _colonnes, 0, 0);
  }

  /**
   * Constructeur simple.
   * @param _sprite Chemin d'accès au fichier de la sprite.
   * @param _lignes Nombre de lignes de la sprite.
   * @param _colonnes Nombre de colonnes de la sprite.
   * @param _x Coordonnée x de la sprite.
   * @param _y Coordonnée y de la sprite.
   */
  Sprite(String _sprite, int _lignes, int _colonnes, float _x, float _y) {
    this(GestionnaireSprite.decouperTuileSprite(_sprite, _lignes, _colonnes, true), _x, _y, true);
  }

  /**
   * Constructeur complet.
   * @param _trames Trames d'animations.
   * @param _x Coordonnée x de la sprite.
   * @param _y Coordonnée y de la sprite.
   * @param _visible Visibilité de la sprite.
   */
  private Sprite(PImage[] _trames, float _x, float _y, boolean _visible) {
    chemin = new SpriteChemin();
    definirPosition(_x, _y);
    definirTrames(_trames);
    
    visible = _visible;
    animation = true;
    facteurTrame = 1;
  }

  /**
   * Définir l'état de la sprite.
   * @param _etat État de la sprite.
   */
  void definirEtat(Etat _etat) {
    etat = _etat;
  }

  /**
   * Définir les trames d'animations de la sprite.
   * @param _trames Trames d'animation.
   */
  void definirTrames(PImage[] _trames) {
    trames = _trames;
    
    /* Largeur de la sprite. */
    largeur = _trames[0].width;
    demiLargeur = largeur/2.0;
    
    /* Hauteur de la sprite. */
    hauteur = _trames[0].height;
    demiHauteur = hauteur/2.0;
    
    nombreTrames = _trames.length;
  }

  /**
   * Récupérer le canal alpha pour un pixel.
   * @param _x Coordonnée x du pixel à vérifier.
   * @param _y Coordonnée y du pixel à vérifier.
   */
  float recupererAlpha(float _x, float _y) {
    int x = int(_x);
    int y = int(_y);
    PImage trame = trames[trameActuelle];
    return alpha(trame.get(x, y));
  }

  /**
   * Récupérer le nombre de trames de la sprite.
   */
  int recupererNombreTrames() {
    return nombreTrames;
  }

  /**
   * Vérifier si la sprite est en animation.
   */
  boolean verifierAnimation() {
    return animation;
  }

  /**
   * Aligner la sprite.
   * @param _alignementH Alignement horizontal.
   * @param _alignementV Alignement vertical.
   */
  void aligner(int _alignementH, int _alignementV) {
    /* Aligner à gauche. */
    if (_alignementH == GAUCHE) {
      alignementH = demiLargeur;
    }
    /* Aligner au centre. */
    else if (_alignementH == CENTRE) {
      alignementH = 0;
    }
    /* Aligner à droite. */
    else if(_alignementH == DROITE) {
      alignementH = -demiLargeur;
    }
    mx = alignementH;

    /* Aligner en haut. */
    if (_alignementV == HAUT) {
      alignementV = demiHauteur;
    }
    /* Aligner au centre. */
    else if(_alignementV == CENTRE) {
      alignementV = 0;
    }
    /* Aligner en bas. */
    else if(_alignementV == BAS) {
      alignementV = -demiHauteur;
    }
    my = alignementV;
  }

  /**
   * Définir l'alignement de la sprite.
   * @param _x Alignement horizontal.
   * @param _y Alignement vertical.
   */
  void definirAlignement(float _x, float _y) {
    /* Décalage de la sprite. */
    mx = _x;
    my = _y;

    /* Alignement de la sprite. */
    alignementH = _x;
    alignementV = _y;
  }  
  
  /**
   * Ancrer la sprite.
   * @param _ancrageH Ancrage horizontal de la sprite.
   * @param _ancrageV Ancrage vertical de la sprite.
   */
  void ancrer(int _ancrageH, int _ancrageV) {
    /* Ancrer à gauche. */
    if (_ancrageH == GAUCHE) {
      ancrageH = 0;
    }
    /* Ancrer au centre. */
    else if (_ancrageH == CENTRE) {
      ancrageH = demiLargeur;
    }
    /* Ancrer à droite. */
    else if (_ancrageH == DROITE)  {
      ancrageH = largeur;
    }

    /* Ancrer en haut. */
    if (_ancrageV == HAUT) {
      ancrageV = 0;
    }
    /* Ancrer au centre. */
    else if (_ancrageV == CENTRE) {
      ancrageV = demiHauteur;
    }
    /* Ancrer en bas. */
    else if(_ancrageV == BAS) {
      ancrageV = hauteur;
    }
  }
  
  /**
   * Définir le point d'ancrage de la sprite.
   */
  void definirAncrage(float _x, float _y) {
    ancrageH = _x;
    ancrageV = _y;
  }

  /**
   * Désactiver la rotation de la sprite.
   * @param _rotation Faut-il désactiver la rotation ?
   */
  void desactiverRotation(boolean _rotation) {
    chemin.desactiverRotation(_rotation);
  }

  /**
   * Rotation horizontale de la sprite.
   */
  void rotationHorizontale() {
    rotationHorizontale = !rotationHorizontale;
    
    /* Pour chaque trame. */
    for (PImage img : trames) {
      img.loadPixels();
      
      /* Tableau de pixels. */
      int[] pxl = new int[img.pixels.length];
      
      /* Définition de l'image. */
      int w = int(largeur);
      int h = int(hauteur);
      
      /* Pour chaque pixel. */
      for (int x=0; x<w; x++) {
        for (int y=0; y<h; y++) {
          /* Rotation horizontale. */
          pxl[x + y*w] = img.pixels[((w-1)-x) + y*w]; 
        }
      }

      /* Écrasement de l'ancienne image. */
      img.pixels = pxl;

      img.updatePixels();
    }
  }

  /**
   * Rotation verticale de la sprite.
   */
  void rotationVerticale() {
    rotationVerticale = !rotationVerticale;

    /* Pour chaque trame. */
    for(PImage img : trames) {
      img.loadPixels();

      /* Tableau de pixels. */
      int[] pxl = new int[img.pixels.length];

      /* Définition de l'image. */
      int w = int(largeur);
      int h = int(hauteur);

      /* Pour chaque pixel. */
      for (int x=0; x<w; x++) {
        for (int y=0; y<h; y++) {
          /* Rotation verticale. */
          pxl[x + y*w] = img.pixels[x + ((h-1)-y)*w];
        }
      }

      /* Écrasement de l'ancienne image. */
      img.pixels = pxl;

      img.updatePixels();
    }
  }

  /**
   * Définir le décalage de trame pour synchroniser la
   * sprite en fonction de différentes trames.
   * @param _decalage Décalage de trame.
   */
  void definirDecalageTrame(int _decalage) {
    decalageTrame = _decalage;
  }

  /**
   * Définir la vitesse d'animation.
   * @param _facteur Facteur de vitesse d'animation.
   */
  void definirVitesseAnimation(float _facteur) {
    facteurTrame = _facteur;
  }

  /**
   * Définir le décalage du chemin.
   * @param _decalage Décalage du chemin.
   */
  void definirDecalageChemin(int _decalage) {
    chemin.definirDecalage(_decalage);
  }

  /**
   * Récupérer la trame actuelle d'animation.
   */
  PImage recupererTrame() {
    /* Récupérer le numéro de la trame actuelle. */
    trameActuelle = recupererNumeroTrameActuelle();
    
    /* Si le chemin possède des trames. */
    if (chemin.size() > 0) {
      /* Récupération des informations de la trame suivante. */
      float[] infoChemin = chemin.recupererInformationsTrameSuivante();
      definirEchelle(infoChemin[2], infoChemin[3]);
      definirRotation(infoChemin[4]);

      /* Si la sprite possède un etat. */
      if(etat != null) {
        etat.definirDecalageActeur(infoChemin[0], infoChemin[1]);
        etat.definirDimensionsActeur(largeur*ex, hauteur*ey, alignementH*ex, alignementV*ey);
      } else {
        mx = infoChemin[0];
        my = infoChemin[1];
      }
    }

    return trames[trameActuelle];
  }

  /**
   * Récupérer le numéro de la trame actuelle.
   */
  int recupererNumeroTrameActuelle() {
    /* Si l'état n'est pas une boucle, et que l'animation est finie. */
    if (chemin.size() > 0 && !chemin.boucle && compteurTrames == chemin.size()) {
      /* Si l'état existe. */
      if (etat != null) {
        /* L'état est fini. */
        etat.fini();
      }
      animation = false;
      return nombreTrames-1;
    }

    float trame = ((frameCount + decalageTrame) * facteurTrame) % nombreTrames;
    compteurTrames++;

    return int(trame);
  }

  /**
   * Vérifier si la sprite a fini son animation.
   */
  boolean peutChanger() {
    if(chemin.size() == 0) {
      return true;
    }
    return !animation;
  }

  /**
   * Définir le chemin comme étant une boucle.
   */
  void definirBoucle(boolean _boucle) {
    chemin.definirBoucle(_boucle);
  }

  /**
   * Arrêter la sprite.
   */
  void arreter() {
    animation = false;
  }

  /**
   * Réinitialiser la sprite.
   */
  void reinitialiser() {
    if(chemin.size() > 0) {
      chemin.reinitialiser();
      animation = true;
    }
    compteurTrames = 0;
    decalageTrame = -frameCount;
  }

  /**
   * Supprimer le chemin de la sprite.
   */
  void supprimerChemin() {
    chemin = new SpriteChemin();
  }

  /**
   * Ajouter un point de chemin.
   * @param _x Coordonnée x du point.
   * @param _y Coordonnée y du point.
   * @param _ex Echelle x de la sprite.
   * @param _ey Echelle y de la sprite.
   * @param _rotation Rotation de la sprite.
   * @param _duree Durée de déplacement.
   */
  void ajouterPointChemin(float _x, float _y, float _ex, float _ey, float _rotation, int _duree) {
    chemin.ajouterPoint(_x, _y, _ex, _ey, _rotation, _duree);
  }

  /**
   * Ajouter un chemin linéaire.
   * @param _x1 Coordonnée x de départ.
   * @param _y1 Coordonnée y de départ.
   * @param _ex1 Echelle x de départ de la sprite.
   * @param _ey1 Echelle y de départ de la sprite.
   * @param _rotation1 Rotation de départ de la sprite.
   * 
   * @param _x2 Coordonnée x d'arrivée.
   * @param _y2 Coordonnée y d'arrivée.
   * @param _ex2 Echelle x d'arrivée de la sprite.
   * @param _ey2 Echelle y d'arrivée de la sprite.
   * @param _rotation2 Rotation d'arrivée de la sprite.
   * 
   * @param _duree Durée de déplacement.
   */
  void ajouterChemin(float _x1, float _y1, float _ex1, float _ey1, float _rotation1,
                     float _x2, float _y2, float _ex2, float _ey2, float _rotation2,
                     float _duree) {
    chemin.ajouterLigne(_x1, _y1, _ex1, _ey1, _rotation1, _x2, _y2, _ex2, _ey2, _rotation2, _duree);
  }

  /**
   * Vérifier qu'une position est sur la sprite.
   * @param _x Coordonnée x à vérifier.
   * @param _y Coordonnée y à vérifier.
   */
  boolean verifierPosition(float _x, float _y) {
    _x -= mx - demiLargeur;
    _y -= my - demiHauteur;
    return x <= _x && _x <= x+largeur && y <= _y && _y <= y+hauteur;
  }

  /**
   * Affichage de la sprite.
   */
  void draw() {
    draw(0,0);
  }

  /**
   * Affichage de la sprite.
   * @param _dx Décalage x de la sprite.
   * @param _dy Décalage y de la sprite.
   */
  void draw(float _dx, float _dy) {
    /* Si la sprite est visible. */
    if (visible) {
      /* Récupération de la trame actuelle. */
      PImage img = recupererTrame();

      /* Récupération des coordonnées de la trame. */
      float imx = x + _dx + mx - demiLargeur;
      float imy = y + _dy + my - demiHauteur;

      /* Affichage de la trame. */
      image(img, imx, imy);
    }
  }
  
  /**
   * Affichage de la sprite.
   */
  void draw(float _x1, float _y1, float _x2, float _y2) {
    this.draw();
  }

  /* Déterminer si l'objet est visible dans le cadre d'affichage actuel. */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) { 
    return true; 
  }

  /**
   * Affichage de l'objet.
   */
  void afficherObjet() {
    println("[Librairie]: Appel à Sprite.afficherObjet() au lieu de Sprite.draw()."); 
  }
}