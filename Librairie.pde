/**
 * Librairie 2D pour Processing, inspirée du travail de Mike Kamermans.
 * @author Joao Brilhante, Keyla Plichon.
 * @version Alpha 0.1
 */

/**
 * Liste des écrans.
 */
HashMap<String, Ecran> ecrans;

/* Écran actif. */
Ecran ecranActif;

/**
 * Variables arbitraires.
 */
int CENTRE = 3;
int GAUCHE = 37;
int DROITE = 39;
int BAS = 40;
int HAUT = 101;

/**
 * Initialisation de la librairie.
 */
void setup() {
  /* Taille de la fenêtre fournie par des variables. */
  surface.setSize(largeurEcran, hauteurEcran);
  noLoop();
  
  /* Initialisation des écrans. */
  ecrans = new HashMap<String, Ecran>();

  /* Initialisation des modules. */
  GestionnaireSprite.initialisation(this, taillePixel);
  GestionnaireSonore.initialisation(this);
  DetectionCollision.initialisation(this);
  
  /* Initialisation fournie. */
  initialisation();
}

/* Affichage. */
void draw() { 
  /* Écran actif. */
  ecranActif.draw(); 
}

//--------------------------//
//        CONTROLES.        //
//--------------------------//

void keyPressed()    { ecranActif.keyPressed(key, keyCode); }
void keyReleased()   { ecranActif.keyReleased(key, keyCode); }
void mouseMoved()    { ecranActif.mouseMoved(mouseX, mouseY); }
void mousePressed()  { ecranActif.mousePressed(mouseX, mouseY, mouseButton); }
void mouseDragged()  { ecranActif.mouseDragged(mouseX, mouseY, mouseButton); }
void mouseReleased() { ecranActif.mouseReleased(mouseX, mouseY, mouseButton); }
void mouseClicked()  { ecranActif.mouseClicked(mouseX, mouseY, mouseButton); }

/**
 * Ajouter un écran.
 * @param _nom Nom de l'écran à ajouter.
 * @param _ecran Écran à ajouter.
 */
void ajouterEcran(String _nom, Ecran _ecran) {
  /* Ajout de l'écran à la liste. */
  ecrans.put(_nom, _ecran);

  /* Si l'écran actif est nul. */
  if (ecranActif == null) {
    /* Définition de l'écran actif. */
    ecranActif = _ecran;
    loop();
  } else {
    /* En cas d'ajout d'écran, la musique est arrêtée. */
    GestionnaireSonore.arreter();
  }
}

/**
 * Définir l'écran actif en gardant une référence à
 * l'ancien écran.
 * @param _nom Nom de l'écran actif.
 */
Ecran definirEcranActif(String _nom) {
  Ecran ancienEcran = ecranActif;
  ecranActif = ecrans.get(_nom);
  
  /* Si l'ancien écran n'est pas nul. */
  if (ancienEcran != null) {
    /* Nettoyage de l'ancien écran. */
    ancienEcran.nettoyer();

    /* La musique est arrêtée. */
    GestionnaireSonore.arreter();
  }

  /* Retourne l'ancien écran. */
  return ancienEcran;
}

/**
 * Supprimer un écran.
 * @param _nom Nom de l'écran à supprimer.
 */
void supprimerEcran(String _nom) {
  /* S'il ne s'agit pas de l'écran actif. */
  if (ecrans.get(_nom) != ecranActif) {
    ecrans.remove(_nom);
  }
}

/**
 * Récupérer un écran.
 * @param _nom Nom de l'écran à récupérer.
 */
Ecran recupererEcran(String _nom) {
  return ecrans.get(_nom);
}

/**
 * Supprimer tous les écrans.
 */
void supprimerEcrans() {
  ecrans = new HashMap<String, Ecran>();
  ecranActif = null;
}
