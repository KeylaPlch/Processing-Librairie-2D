/**
 * Le gestionnaire de sprite permet de transformer un spritesheet
 * en tableau d'images. Un spritesheet étant une simple image
 * contenant plusieurs trames d'animations équidistantes le long
 * de l'axe x et y.
 */
static class GestionnaireSprite {
  /**
   * Sketch principal.
   */
  static PApplet sketch;

  /**
   * Taille d'un pixel.
   */
  static int taillePixel;
  
  /**
   * Constructeur complet.
   * @param _sketch Sketch principal.
   * @param _pixel Taille d'un pixel.
   */
  static void initialisation(PApplet _sketch) {
    sketch = _sketch;
    taillePixel = 1;
  }
  
  /**
   * Définir la taille d'un pixel.
   * @param _taillePixel Taille d'un pixel.
   */
  void definirTaillePixel(int _taillePixel) {
    taillePixel = _taillePixel;
  }
  
  /**
   * Découper une tuile de sprite.
   * @param _spritesheet Spritesheet à découper.
   * @param _colonnes Nombre de colonnes à découper.
   * @param _lignes Nombre de lignes à découper.
   * @return Un tableau de sprites.
   */
  static PImage[] decouperTuileSprite(String _spritesheet, int _colonnes, int _lignes) {
    return decouperTuileSprite(_spritesheet, _colonnes, _lignes, true);
  }

  /**
   * Découper une tuile de sprite.
   * @param _spritesheet Spritesheet à découper.
   * @param _colonnes Nombre de colonnes à découper.
   * @param _lignes Nombre de lignes à découper.
   * @param _gaucheDroite Découpage de gauche à droite d'abord.
   * @return Un tableau de sprites.
   */
  private static PImage[] decouperTuileSprite(String _spritesheet, int _lignes, int _colonnes, boolean _gaucheDroite) {
    /* Si le sketch global n'existe pas. */
    if (sketch == null) {
      println("[Librairie]: Le gestionnaire de sprite nécessite une référence au sketch principal.");
    }

    /* Charger le spritesheet. */
    PImage spritesheet = chargerSprite(_spritesheet);

    /* Indice de la sprite actuelle. */
    int indice = 0;

    /* Nombre de sprites du spritesheet. */
    int compteurSprite = _lignes * _colonnes;
    
    /* Largeur d'une sprite */
    int largeurSprite = spritesheet.width/_colonnes;

    /* Hauteur d'une sprite. */
    int hauteurSprite = spritesheet.height/_lignes;

    /* Tableau de sprites. */
    PImage[] sprites = new PImage[compteurSprite];

    /* De gauche à droite puis de haut en bas. */
    if(_gaucheDroite){
      /* Pour chaque ligne. */
      for(int i = 0; i < _lignes; i++) {
        /* Pour chaque colonne. */
        for(int j = 0; j < _colonnes; j++) {
          sprites[indice++] = spritesheet.get(j * largeurSprite, i * hauteurSprite, largeurSprite, hauteurSprite);
        }
      }
    }
    /* De haut en bas puis de gauche à droite. */
    else {
      /* Pour chaque colonne. */
      for(int j = 0; j < _colonnes; j++) {
        /* Pour chaque ligne. */
        for(int i = 0; i < _lignes; i++) {
          sprites[indice++] = spritesheet.get(j * largeurSprite, i * hauteurSprite, largeurSprite, hauteurSprite);
        }
      }
    }
    return sprites;
  }
  
  /**
   * Récupère une sprite et la redimensionne en proche voisin.
   * @param _sprite Chemin d'accès au fichier de la sprite.
   */
  static PImage chargerSprite(String _sprite) {
    /* Chargement de l'image. */
    PImage image = sketch.loadImage(_sprite);

    /* Taille de l'image redimensionnée. */
    int nouvelleLargeur = int(image.width * taillePixel);
    int nouvelleHauteur = int(image.height * taillePixel);
      
    /* Création de l'image redimensionnée. */
    PImage nouvelle = sketch.createImage(nouvelleLargeur, nouvelleHauteur, ARGB);
    
    image.loadPixels();
    nouvelle.loadPixels();
    /* Pour chaque pixel de l'image redimensionnée. */
    for(int i = 0; i < nouvelle.height; i++) {
      for(int j = 0; j < nouvelle.width; j++) {
        /* Correspondance des pixels. */
        int x = int(map(j, 0, nouvelle.width, 0, image.width));
        int y = int(map(i, 0, nouvelle.width, 0, image.width));
        int index = x + y * image.width;
        nouvelle.pixels[j + i * nouvelle.width] = image.pixels[index];
      }
    }
    image.updatePixels();
    nouvelle.updatePixels();
    
    return nouvelle;
  }
}
