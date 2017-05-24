/**
 * Position.
 */
class Position {
  /* 
   * Coordonnées de l'objet.
   */
  float x, y;

  /*
   * Taille de l'objet.
   */
  float largeur, hauteur;

  /**
   * Vitesse de l'objet.
   */
  float vx, vy;

  /**
   * Accélération de l'objet.
   */
  float ax, ay;
  
  /**
   * Compteur de trames d'accélération.
   */
  int compteurAcceleration;

  /**
   * Coefficients de vitesse.
   */
  float cx, cy;

  /**
   * Forces externes à l'objet.
   */
  float fx, fy;

  /**
   * Décalage dans les coordonnées du monde.
   */
  float mx, my;
  
  /**
   * Échelle de l'objet.
   */
  float ex, ey;

  /**
   * Rotation de l'objet (en radians).
   */
  float rotation;

  /* 
   * Rotation horizontale. 
   */
  boolean rotationHorizontale;
  
  /**
   * Rotation verticale.
   */
  boolean rotationVerticale;

  /**
   * Direction de l'objet.
   */
  float direction;

  /**
   * L'objet est-il en animation ?
   */
  boolean animation;

  /**
   * L'objet est-il visible ?
   */
  boolean visible;


  /**
   * Initialisation d'un objet.
   */
  Position() {
    /* Coefficients de vitesse par défaut. */
    cx = 1;
    cy = 1;

    /* Échelle par défaut. */
    ex = 1;
    ey = 1;

    /* Direction. */
    direction = -1; // -1 signifie "non défini".

    /* Animation. */
    animation = true;

    /* Visibilité. */
    visible = true;
  }

  /**
   * Copier un autre objet.
   * @param _autre L'autre objet.
   */
  void copier(Position _autre) {
    x = _autre.x;
    y = _autre.y;
    largeur = _autre.largeur;
    hauteur = _autre.hauteur;
    rotationHorizontale = _autre.rotationHorizontale;
    rotationVerticale = _autre.rotationVerticale;
    mx = _autre.mx;
    my = _autre.my;
    ex = _autre.ex;
    ey = _autre.ey;
    rotation = _autre.rotation;
    vx = _autre.vx;
    vy = _autre.vy;
    cx = _autre.cx;
    cy = _autre.cy;
    fx = _autre.fx;
    fy = _autre.fy;
    ax = _autre.ax;
    ay = _autre.ay;
    compteurAcceleration = _autre.compteurAcceleration;
    direction = _autre.direction;
    animation = _autre.animation;
    visible = _autre.visible;
  }

  /**
   * Récupérer les coordonnées de la boîte de collision.
   * @return Tableau de coordonnées de la boîte de collision.
   */
  float[] recupererDelimitations() {
    return new float[]{x+mx-largeur/2, y-my-hauteur/2, // Coin supérieur gauche.
                       x+mx+largeur/2, y-my-hauteur/2, // Coin supérieur droit.
                       x+mx+largeur/2, y-my+hauteur/2, // Coin inférieur droit.
                       x+mx-largeur/2, y-my+hauteur/2}; // Coin inférieur gauche.
  }

  /**
   * Vérification de collision avec un autre objet.
   * @param _autre L'autre objet.
   * @return Tableau d'informations de collision.
   */
  float[] collision(Position _autre) {
    /* Récupération des délimitations des objets. */
    float[] limites = recupererDelimitations();
    float[] autreLimites = _autre.recupererDelimitations();
    if(limites == null || autreLimites == null) return null;
    
    /* Calcul du milieu des objets. */
    float x1 = (limites[0] + limites[2])/2;
    float y1 = (limites[1] + limites[5])/2;
    float x2 = (autreLimites[0] + autreLimites[2])/2;
    float y2 = (autreLimites[1] + autreLimites[5])/2;

    /* Différence de coordonnées. */
    float dx = x2 - x1;
    float dy = y2 - y1;

    /* Différence de taille. */
    float dl = (largeur + _autre.largeur)/2;
    float dh = (hauteur + _autre.hauteur)/2;

    /* S'il n'y a pas de collision. */
    if(abs(dx) > dl || abs(dy) > dh) return null;
      
    /* Calcul de l'angle de collision. */
    float angle = atan2(dy,dx);
    if(angle < 0) { angle += 2*PI; }
      
    /* Calcul des coordonnées de collision. */
    float safedx = dl - dx,
    safedy = dh - dy;

    /* Tableau d'informations de collision. */
    return new float[] {dx, dy, angle, safedx, safedy};
  }

  /**
   * Appliquer toutes les transformations.
   */
  void appliquerTransformations() {
    /* Position de l'objet. */
    translate((int)x, (int)y); // On utilise des entiers.

    /* Rotations de l'objet. */
    if (rotation != 0) { rotate(rotation); }
    if(rotationHorizontale) { scale(-1, 1); }
    if(rotationVerticale) { scale(1, -1); }
    
    /* Échelle de l'objet. */
    scale(ex, ey);

    /* Position de l'objet dans le monde. */
    translate((int)mx, (int)my); // On utilise des entiers.
  }
  
  /**
   * Récupérer les informations de débogage.
   */
  String deboguer() {
    return "Position: " + x + ";" + y +
           ", Vitesse: " + vx + ";" + vy +
           ", Coef. de vitesse: " + cx + ";" + cy  +
           ", Forces: " + fx + ";" + fy +
           ", Accélération: " + ax + ";" + ay +
           ", Monde: " + mx + ";" + my;
  }
}