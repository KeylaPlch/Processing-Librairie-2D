/**
 * Les acteurs sont des objets constitués de plusieurs états,
 * chaque état étant associé à une sprite particulière,
 * et un comportement particulier.
 */
abstract class Acteur extends Positionnable {
  /**
   * Nom de l'acteur.
   */
  String nom;

  /**
   * L'état actif de l'acteur.
   */
  Etat actif;

  /**
   * Liste de tous les états de l'acteur.
   */
  HashMap<String, Etat> etats;

  /**
   * La couche du niveau dans laquelle l'acteur se trouve.
   */
  CoucheNiveau couche;

  /**
   * L'acteur est-il actuellement en collision ?
   */
  boolean collision;

  /**
   * L'acteur interagit-il avec les autres acteurs ?
   */
  boolean interactif;
  
  /**
   * L'acteur interagit-il seulement avec les joueurs ?
   * @type {Boolean}
   */
  boolean interactifJoueur;

  /**
   * Désactiver l'interaction de l'acteur pendant un certain nombre de frames.
   */
  int desactiverInteraction;

  /**
   * L'acteur est-il persistant dans la fenêtre d'affichage ?
   */
  boolean persistant;

  /**
   * L'acteur doit-il être supprimé ?
   */
  boolean supprimer;

  /**
   * Alignement de l'acteur.
   */
  float alignementH, alignementV;

  /**
   * Déboguage.
   */
  boolean deboguage;

  /**
   * Constructeur simple.
   * @param _nom Nom de l'acteur.
   */
  Acteur(String _nom) {
    nom = _nom;
    deboguage = false;
    interactif = true;
    persistant = true;
    etats = new HashMap<String, Etat>();
  }

  /**
   * Constructeur complet.
   * @param _nom Nom de l'acteur.
   * @param _cx Coefficient de vitesse x.
   * @param _cx Coefficient de vitesse y.
   */
  Acteur(String _nom, float _cx, float _cy) {
    this(_nom);
    definirCoefficientVitesse(_cx, _cy);
  }

  /**
   * Ajouter un état à la liste de l'acteur.
   * @param _etat État à ajouter.
   */
  void ajouterEtat(Etat _etat) {
    /* Définition de l'acteur de l'état. */
    _etat.definirActeur(this);

    /* L'état existe-t-il déjà ? */
    boolean existe = (etats.get(_etat.nom) != null);

    /* On ajoute l'état à la liste. */
    etats.put(_etat.nom, _etat);

    /* Si l'état n'existe pas, ou que l'état déjà existant est actif. */
    if (!existe || (existe && _etat.nom == actif.nom)) {
      /* Si l'état actif est nul. */
      if (actif == null) { 
        /* Définition de l'état actif. */
        actif = _etat; 
      } else {
        /* Échange de l'état. */
        echangerEtat(_etat);
      }
      /* Mise à jour des informations de position. */
      informationsPosition();
    }
  }
  
  /**
   * Récupérer un état grâce à son nom.
   * @param _nom Nom de l'état à récupérer.
   */
  Etat recupererEtat(String _nom) {
    return etats.get(_nom);
  }
  
  /**
   * Récupérer la sprite actuelle de l'animation.
   */
  PImage recupererSprite() {
    /* Si l'état actif n'est pas nul. */
    if (actif == null) return null;
    return actif.sprite.recupererTrame();
  }
  
  /**
   * Définir la couche du niveau de l'acteur.
   * @param _couche Couche à définir.
   */
  void definirCoucheNiveau(CoucheNiveau _couche) {
    this.couche = _couche;
  }

  /**
   * Récupérer la couche du niveau de l'acteur.
   */
  CoucheNiveau recupererCoucheNiveau() {
    return couche;
  }

  /**
   * Définir l'état actuel de l'acteur.
   * @param _nom Nom de l'état.
   */
  void definirEtatActuel(String _nom) {
    /* Récupération de l'état. */
    Etat temporaire = etats.get(_nom);
    
    /* Si l'état actif n'est pas nul, et que l'état temporaire n'est pas déjà celui actif. */
    if (actif != null && temporaire != actif) {
      temporaire.reinitialiser();
      echangerEtat(temporaire);
    } else {
      actif = temporaire;
    }
  }
  
  /**
   * Echanger l'état actif par un nouveau.
   * @param _etat Nouvel état.
   */
  void echangerEtat(Etat _etat) {
    /* Récupération de l'ancienne sprite. */
    Sprite ancienneSprite = actif.sprite;
    
    /* Récupération d'informations de rotation. */
    boolean rotationHorizontale = false, rotationVerticale = false;
    if (ancienneSprite != null) {
      rotationHorizontale = ancienneSprite.rotationHorizontale;
      rotationVerticale = ancienneSprite.rotationVerticale;
    }

    /* Définition du nouvel état. */
    actif = _etat;
    
    /* Récupération de la nouvelle sprite. */
    Sprite nouvelleSprite = _etat.sprite;
    if (nouvelleSprite != null) {
      if (rotationHorizontale) nouvelleSprite.rotationHorizontale();
      if (rotationVerticale) nouvelleSprite.rotationVerticale();
      informationsPosition();

      /* Si les deux sprites existent bel et bien. */
      if (ancienneSprite != null) {
        /* On s'assure d'échanger les sprites de l'état. */
        gererEchangeSprite(ancienneSprite, nouvelleSprite);
      }
    }
  }

  /**
   * Gérer l'échange de sprites.
   * @param _ancienneSprite L'ancienne sprite de l'acteur.
   * @param _nouvelleSprite Nouvelle sprite de l'acteur.
   */
  void gererEchangeSprite(Sprite _ancienneSprite, Sprite _nouvelleSprite) {
    /* Récupération des points d'ancrage des sprites. */
    float ax1 = _ancienneSprite.ancrageH,
    ay1 = _ancienneSprite.ancrageV,
    ax2 = _nouvelleSprite.ancrageH,
    ay2 = _nouvelleSprite.ancrageV;

    /* Variation de l'ancrage. */
    float dx = (ax2-ax1)/2.0,
    dy = (ay2-ay1)/2.0;
    
    /* Ajustement de la position. */
    x -= dx;
    y -= dy;
  }

  /**
   * Mise à jour des dimensions de l'auteur en fonction de son état actif.
   */
  void informationsPosition() {
    largeur  = actif.sprite.largeur;
    hauteur = actif.sprite.hauteur;
    alignementH = actif.sprite.alignementH;
    alignementV = actif.sprite.alignementV;
  }

  /**
   * Contraindre la position de l'acteur en fonction de la couche de niveau.
   */
  void contraindrePosition() {
    float w2 = largeur/2;
    float lw = couche.largeur;

    /* Si l'acteur dépasse la gauche de l'écran. */
    if (x < w2) { x = w2; }

    /* Si l'acteur dépasse la droite de l'écran. */
    if (x > lw - w2) { x = lw - w2; }
  }

  /**
   * Récupérer les délimitations de l'objet.
   * @return Tableau de coordonnées de la boîte de collision.
   */
  float[] recupererDelimitations() {
    /* Si l'état actif n'est pas nul. */
    if(actif == null) return null;
    
    /* Récupération des délimitations de l'état actif. */
    float[] limites = actif.sprite.recupererDelimitations();
    
    /* Si la rotation n'est pas nulle. */
    if(rotation != 0) {
      /* Récupération des coordonnées des délimitations. */
      float x1 = limites[0], y1 = limites[1],
      x2 = limites[2], y2 = limites[3],
      x3 = limites[4], y3 = limites[5],
      x4 = limites[6], y4 = limites[7];
      
      /* Application de la rotation à ces coordonnées. */
      limites[0] = x1*cos(rotation) - y1*sin(rotation);
      limites[1] = x1*sin(rotation) + y1*cos(rotation);
      limites[2] = x2*cos(rotation) - y2*sin(rotation);
      limites[3] = x2*sin(rotation) + y2*cos(rotation);
      limites[4] = x3*cos(rotation) - y3*sin(rotation);
      limites[5] = x3*sin(rotation) + y3*cos(rotation);
      limites[6] = x4*cos(rotation) - y4*sin(rotation);
      limites[7] = x4*sin(rotation) + y4*cos(rotation);
    }

    /* Translations. */
    limites[0] += x + mx; limites[1] += y + my; // Coin supérieur gauche.
    limites[2] += x + mx; limites[3] += y +my; // Coin supérieur droit.
    limites[4] += x + mx; limites[5] += y + my; // Coin inférieur droit.
    limites[6] += x + mx; limites[7] += y + my; // Coin inférieur gauche.

    return limites;
  }

  /**
   * Vérification de collision avec un autre acteur.
   * @param _autre L'autre acteur.
   * @return Tableau d'informations de collision.
   */
  float[] collision(Acteur _autre) {
    /* Récupération des informartions de collision. */
    float[] tableau = super.collision(_autre);
    return tableau;
  }

  /**
   * Lorsque l'acteur prend un coup.
   */
  void coup() { /* A écraser. */ }

  /**
   * Attacher une limite à l'acteur.
   * @param _limite Limite à attacher.
   * @param _correction Correction de la position de l'acteur.
   */  
  void attacherLimite(Limite _limite, float[] _correction) {
    /* On vérifie que la limite n'est pas déjà attachée à l'acteur. */
    if(limites.contains(_limite)) return;
    
    /* Ajouter la limite. */
    limites.add(_limite);

    /* Arrêter l'acteur. */
    float[] original = {this.vx - (fx * cx), this.vy - (fy * cy)};
    arreter(_correction[0], _correction[1]);

    /* Ajout d'une vitesse redirigée par la limite. */
    float[] redirection = _limite.redirigerForce(original[0], original[1]);
    ajouterVitesse(redirection[0], redirection[1]);

    /* Appel de l'événement. */
    EvenementBloquer(_limite, _correction, original);

    /* Actualiser l'acteur. */
    actualiser();
  }

  /**
   * Arrêter le mouvement de l'acteur et le déplacer.
   * @param _dx Déplacement x de l'acteur.
   * @param _dy Déplacement y de l'acteur.
   */
  void arreter(float _dx, float _dy) {
    float resolution = 50;
    x = int(resolution*(x+_dx))/resolution;
    y = int(resolution*(y+_dy))/resolution;
    
    /* Arrêt du mouvement de l'acteur. */
    vx = 0;
    vy = 0;

    /* Arrêt de l'accélération. */
    compteurAcceleration = 0;
  }

  /**
   * Définir l'interaction de l'acteur.
   * @param _interactif L'acteur est-il interactif ?
   */
  void definirInteraction(boolean _interactif) {
    interactif = _interactif;
  }

  /**
   * Définir cet acteur comme uniquement interactif avec un joueur.
   * @param _interactifJoueur Interaction avec le joueur uniquement.
   */
  void definirInteractionJoueur(boolean _interactifJoueur) {
    interactifJoueur = _interactifJoueur;
  }

  /**
   * Vérifier si l'acteur est désactivé.
   */
  boolean estDesactiver() {
    /* Si l'interaction est désactivée. */
    if(desactiverInteraction > 0) {
      desactiverInteraction--;
      return true;
    }

    /* Par défaut, l'acteur est actif. */
    return false;
  }

  /**
   * Désactiver l'interaction de l'acteur pendant un certain nombre de trames.
   * @param _trames Nombre de trames.
   */
  void desactiverInteraction(int _trames) {
    desactiverInteraction = _trames;
  }

  /**
   * Supprimer un acteur.
   */
  void supprimerActeur() {
    animation = false;
    visible = false;
    etats = null;
    actif = null;
    supprimer = true;
  }

  /**
   * Vérifier si une position est dans la zone d'affichage.
   * @param _x Coordonnée x à vérifier.
   * @param _y Coordonnée y à vérifier.
   */
  boolean verifierPosition(float _x, float _y) {
    if (actif == null) return false;
    return actif.verifierPosition(_x - recupererX(), _y - recupererY());
  }

  /**
   * Affichage de l'acteur.
   */
  void draw(float _x1, float _y1, float _x2, float _y2) {
    if(!supprimer) EvenementControles();
    super.draw(_x1, _y1, _x2, _y2);
  }

  /**
   * Déterminer si l'objet est visible dans le cadre d'affichage actuel.
   */
  boolean affichable(float _x1, float _y1, float _x2, float _y2) {
    return true;
  }

  /**
   * Affichage de l'objet.
   */
  void afficherObjet() {
    if(actif != null) {
      actif.draw(desactiverInteraction > 0);
      
      /* Si le mode de déboguage est activé. */
      if (deboguage) {
        noFill();
        stroke(255,0,0);
        float[] limites = recupererDelimitations();
        beginShape();
        vertex(limites[0] - x, limites[1] - y);
        vertex(limites[2] - x, limites[3] - y);
        vertex(limites[4] - x, limites[5] - y);
        vertex(limites[6] - x, limites[7] - y);
        endShape(CLOSE);
      }
    }
  }

  //--------------------------//
  //        EVENEMENTS.       //
  //--------------------------//

  /**
   * Événement de bloquage.
   * @param _limite Limite de collision.
   * @param _intersection Tableau d'informations de collision.
   * @param _original Tableaux des anciennes vitesses de l'acteur.
   */
  void EvenementBloquer(Limite _limite, float[] _intersection, float[] _original) {}

  /**
   * Événement de controles.
   */
  void EvenementControles() {}

  /**
   * Événement de collision.
   * @param _autre L'autre acteur en collision.
   * @param _direction Direction de collision.
   */
  void EvenementCollision(Acteur _autre, float[] _direction) {
    collision = true;
  }

  /**
   * Événement de fin d'état.
   * @param _etat État ayant fini son animation.
   */
  void EvenementEtatFini(Etat _etat) {}

  /**
   * Événement de ramassage d'un objet.
   * @param _objet Objet ramassé.
   */
  void EvenementRamasser(Objet _objet) {}

  //--------------------------//
  //        CONTROLES.        //
  //--------------------------//

  /**
   * Liste des touches verrouillées.
   */
  protected final boolean[] verrouillerTouches = new boolean[256];

  /**
   * Liste des touches pressées.
   */
  protected final boolean[] presserTouches = new boolean[256];
  
  /**
   * Liste des codes des touches écoutées.
   */
  protected int[] codesTouches = {};

  /**
   * Lorsqu'une touche est pressée.
   * @param _touche Touche pressée.
   * @param _codeTouche Code de la touche préssée.
   */
  void keyPressed(char _touche, int _codeTouche) {
    /* Pour chaque code de touche. */
    for (int i : codesTouches) { 
      /* Si l'indice et le code de la touche correspondent. */
      if (i == _codeTouche) {
        presserTouche(_codeTouche);
      }
    }
  }

  /**
   * Lorsqu'une touche est relachée.
   * @param _touche Touche relachée.
   * @param _codeTouche Code de la touche relachée.
   */
  void keyReleased(char _touche, int _codeTouche) {
    /* Pour chaque code de touche. */
    for (int i : codesTouches) {
      /* Si l'indice et le code de la touche correspondent. */
      if (i == _codeTouche) {
        relacherTouche(_codeTouche);
      }
    }
  }

  void mouseMoved(int _mouseX, int _mouseY) {}
  void mousePressed(int _mouseX, int _mouseY, int _bouton) {}
  void mouseDragged(int _mouseX, int _mouseY, int _bouton) {}
  void mouseReleased(int _mouseX, int _mouseY, int _bouton) {}
  void mouseClicked(int _mouseX, int _mouseY, int _bouton) {}

  /**
   * Presser une touche.
   * @param _codeTouche Code de la touche à presser.
   */
  private void presserTouche(int _codeTouche) {
    /* Si la touche n'est pas vérouillée. */
    if(!verrouillerTouches[_codeTouche]) {
      /* Presser la touche. */
      presserTouches[_codeTouche] = true;
    }
  }

  /**
   * Relacher une touche.
   * @param _codeTouche Code de la touche à relacher.
   */
  private void relacherTouche(int _codeTouche) {
    /* Relacher la touche. */
    verrouillerTouches[_codeTouche] = false;
    presserTouches[_codeTouche] = false;
  }

  /**
   * Vérouiller une touche afin d'éviter qu'elle ne soit
   * déclenchée à plusieurs reprises.
   * @param _touche Touche à verrouiller.
   */
  protected void verrouillerTouche(char _touche) {
    /* Récupération du code de la touche. */
    int codeTouche = int(_touche);
    
    /* Vérrouillage de la touche. */
    verrouillerTouches[codeTouche] = true;
    presserTouches[codeTouche] = false;
  }

  /**
   * Ajouter la touche aux touches écoutées.
   * @param _touche Touche à écouter.
   */
  protected void gererTouche(char _touche) {
    /* Récupération du code de la touche. */
    int codeTouche = int(_touche);

    /* Nouvelle liste temporaire des touches écoutées. */
    int taille = codesTouches.length;
    int[] _tmp = new int[taille+1];
    arrayCopy(codesTouches, 0, _tmp, 0,taille);

    /* Ajout de la touche à écouter. */
    _tmp[taille] = codeTouche;
    codesTouches = _tmp;
  }

  /**
   * Vérifier si une touche est préssée.
   * @param _touche Touche à écouter.
   * @return La touche est-elle préssée ?
   */
  protected boolean verifierTouche(char _touche) {
    /* Récupération du code de la touche. */
    int codeTouche = int(_touche);
    return presserTouches[codeTouche];
  }
  
  /**
   * Vérifier si aucune touche n'est pressée.
   * @return Aucune touche n'est pressée ?
   */
  protected boolean aucuneTouche() {
    /* Pour chaque touche. */
    for (boolean i : presserTouches) { if (i) return false; }
    for (boolean i : verrouillerTouches) { if (i) return false; }
    return true;
  }
}