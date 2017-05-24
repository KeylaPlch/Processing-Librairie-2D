/**
 * Limite.
 */
class Limite extends Positionnable {
  private float PI2 = 2*PI;
  
  /**
   * Liste des objets pouvant détecter une collision avec une limite.
   */
  ArrayList<AuditeurCollisionLimite> auditeurs;

  /**
   * Coordonnées de la limite.
   */
  float x2, y2;
  float minx, miny, maxx, maxy;

  /**
   * Différence de coordonnées.
   */
  float dx, dy;

  /** 
   * Longueur de la limite.
   */
  float longueur;
  
  /**
   * Angle de la limite.
   */
  float angle;
  float cosa, sina, cosma, sinma;

  /**
   * Friction de la limite.
   * 1 = Pas de friction.
   * < 1 = Friction.
   * > 1 = Accélération.
   */
  float friction;

  /**
   * Limites précédente et suivante.
   */
  Limite precedente, suivante;
  
  /**
   * Seuil de limite.
   */
  float seuilLimite = 1.5;
  
  /**
   * La limite est-elle désactivée ?
   */
  boolean desactiver;

  /**
   * Constructeur d'une limite.
   * @param _x1 Coordonnée x1 de la limite.
   * @param _y1 Coordonnée y1 de la limite.
   * @param _x2 Coordonnée x2 de la limite.
   * @param _y2 Coordonnée y2 de la limite.
   */
  Limite(float _x1, float _y1, float _x2, float _y2) {
    /* Coordonnées de la limite. */
    x = _x1;
    y = _y1;
    x2 = _x2;
    y2 = _y2; 

    /* Différences. */
    dx = x2 - x;
    dy = y2 - y;

    /* Longueur de la limite. */
    longueur = sqrt(dx*dx + dy*dy);

    /* Actualisation. */
    actualiserLimite();
    actualiserAngle();

    /* Friction. */
    friction = 1.0;

    /* Auditeurs. */
    auditeurs = new ArrayList<AuditeurCollisionLimite>();
  }

  /**
   * Définition absolue de la position.
   * @param _x Coordonnée x de la limite.
   * @param _y Coordonnée y de la limite.
   */
  void definirPosition(float _x, float _y) {
    super.definirPosition(_x, _y);
    actualiserLimite();
  }
  
  /**
   * Définition relative de la position.
   * @param _x Coordonnée x à ajouter.
   * @param _y Coordonnée y à ajouter.
   */
  void ajouterPosition(float _x, float _y) {
    super.ajouterPosition(_x, _y);
    actualiserLimite();
  }

  /**
   * Actualiser la limite.
   */
  void actualiserLimite() {
    x2 = x + dx;
    y2 = y + dy;

    /* Coordonnées minimales. */
    minx = min(x, x2);
    miny = min(y, y2);

    /* Coordonnées maximales. */
    maxx = max(x, x2);
    maxy = max(y, y2);
  }
  
  /**
   * Actualiser l'angle de la limite.
   */
  void actualiserAngle() {
    /* Récupération de l'angle. */
    angle = atan2(dy, dx);

    /* Si l'angle est négatif. */
    if (angle < 0) {
      angle += 2*PI;
    }

    cosa = cos(angle);
    sina = sin(angle);
    cosma = cos(-angle);
    sinma = sin(-angle);
  }

  /**
   * Ajouter un auditeur à la limite.
   * @param _auditeur Auditeur à ajouter.
   */
  void ajouterAuditeur(AuditeurCollisionLimite _auditeur) {
    auditeurs.add(_auditeur);
  }
  
  /**
   * Supprimer un auditeur à la limite.
   * @param _auditeur Auditeur à supprimer.
   */
  void supprimerAuditeur(AuditeurCollisionLimite _auditeur) {
    auditeurs.remove(_auditeur);
  }
  
  /**
   * Notifier un auditeur en cas de collision.
   * @param _acteur Acteur responsable de la collision.
   * @param _intersection Tableau d'informations d'intersection.
   */
  void notifierAuditeur(Acteur _acteur, float[] _intersection) {
    /* Pour tous les auditeurs. */
    for (AuditeurCollisionLimite _auditeur: auditeurs) {
      /* Événement de collision. */
      _auditeur.EvenementCollision(this, _acteur, _intersection);
    }
  }

  /**
   * Vérifier qu'un objet est pris en charge par la limite.
   * @param _positionnable Objet à vérifier.
   */
  boolean prisEnCharge(Positionnable _positionnable) {
    float[] bbox = _positionnable.recupererDelimitations();
    float[] nbox = new float[8];
    
    /* Si l'objet positionnable est nul. */
    if (bbox == null) return false;

    /* 
     * Translation des coordonnées de l'objet pour qu'elles soient
     * relatives aux coordonnées de la limite.
     */
    bbox[0] -= x; bbox[1] -= y;
    bbox[2] -= x; bbox[3] -= y;
    bbox[4] -= x; bbox[5] -= y;
    bbox[6] -= x; bbox[7] -= y;
   
    /*
     * Rotation de la boite de collision afin de l'aligner avec
     * l'axe de la limite.
     */
    nbox[0] = bbox[0] * cosma - bbox[1] * sinma;
    nbox[1] = bbox[0] * sinma + bbox[1] * cosma;
    nbox[2] = bbox[2] * cosma - bbox[3] * sinma;
    nbox[3] = bbox[2] * sinma + bbox[3] * cosma;
    nbox[4] = bbox[4] * cosma - bbox[5] * sinma;
    nbox[5] = bbox[4] * sinma + bbox[5] * cosma;
    nbox[6] = bbox[6] * cosma - bbox[7] * sinma;
    nbox[7] = bbox[6] * sinma + bbox[7] * cosma;
    
    /* Récupération des nouveaux minima et maxima. */
    float minix = min(min(nbox[0],nbox[2]), min(nbox[4],nbox[6])),
          maxix = max(max(nbox[0],nbox[2]), max(nbox[4],nbox[6])),
          miniy = min(min(nbox[1],nbox[3]), min(nbox[5],nbox[7])),
          maxiy = max(max(nbox[1],nbox[3]), max(nbox[5],nbox[7]));

    /* Déterminer si l'objet est hors limite. */
    boolean horsLimite = (minix > longueur) || (maxix < 0) || (maxiy < -1.99);
    
    /* Si l'objet n'est pas hors limite, il est pris en charge. */
    return !horsLimite;
  }

  /**
   * Autoriser le passage à travers la limite dans une certaine direction.
   * @param _vx Coordonnée x de la direction.
   * @param _vy Coordonnée y de la direction.
   */
  boolean autoriserPassage(float _vx, float _vy) {
    float[] aligned = DetectionCollision.translationRotation(0, 0, _vx, _vy, 0, 0, dx, dy, angle, cosma, sinma);
    return (aligned[3] < 0);
  }

  /**
   * Rediriger la force le long de cette limite.
   * @param _fx Coordonnée x de la force extérieure.
   * @param _fy Coordonnée y de la force extérieure.
   */
  float[] redirigerForce(float _fx, float _fy) {
    float[] redirection = {_fx, _fy};
    
    /* Si nous sommes autoriser à passer à travers la limite. */
    if (autoriserPassage(_fx, _fy)) {
      return redirection;
    }

    float[] tr = DetectionCollision.translationRotation(0, 0, _fx, _fy, 0, 0, dx, dy, angle, cosma, sinma);
    redirection[0] = friction * tr[2] * cosa;
    redirection[1] = friction * tr[2] * sina;
    return redirection;
  }

  /**
   * Rediriger la force le long de cette limite pour un objet spécifique.
   * @param _positionnable Objet positionnable.
   * @param _fx Coordonnée x de la force extérieure.
   * @param _fy Coordonnée y de la force extérieure.
   */
  float[] redirigerForce(Positionnable _positionnable, float _fx, float _fy) {
    return redirigerForce(_fx, _fy);
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) {
    /* Les limites sont invisibles, donc toujours affichables. */
    return true;
  }

  /**
   * Affichage de l'objet.
   */
  void afficherObjet() {
    strokeWeight(1);
    stroke(255);
    line(0, 0, dx, dy);

    /* 
     * Afficher une flèche afin d'indiquer la direction par laquelle on
     * peut passer à travers la limite.
     */
    float cs = cos(angle-PI/2), ss = sin(angle-PI/2);

    float fx = 10*cs;
    float fy = 10*ss;
    line((dx-fx)/2, (dy-fy)/2, dx/2 + fx, dy/2 + fy);

    float fx2 = 6*cs - 4*ss;
    float fy2 = 6*ss + 4*cs;
    line(dx/2+fx2, dy/2+fy2, dx/2 + fx, dy/2 + fy);

    fx2 = 6*cs + 4*ss;
    fy2 = 6*ss - 4*cs;
    line(dx/2+fx2, dy/2+fy2, dx/2 + fx, dy/2 + fy);
  }

  /**
   * Définir la limite précédente.
   * @param _limite Limite précédente.
   */
  void definirPrecedente(Limite _limite) {
    precedente = _limite;
  }

  /**
   * Définir la limite suivante.
   * @param _limite Limite suivante.
   */
  void definirSuivante(Limite _limite) {
    suivante = _limite;
  }

  /**
   * Activer cette limite.
   */
  void activer() {
    desactiver = false;
  }

  /**
   * Désactiver cette limite.
   */
  void desactiver() {
    desactiver = true;
  }

  /**
   * Récupérer les informations de débogage.
   */
  String deboguer() {
    return x + "," + y + "," + x2 + "," + y2;
  }
}