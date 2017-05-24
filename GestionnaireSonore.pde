import ddf.minim.*;

/**
 * Le gestionnaire de son est une classe statique responsable
 * de la gestion du son. Toute instruction sonore sera envoyée
 * à cette classe qui utilise la librairie Minim.
 */
static class GestionnaireSonore {
  /*
   * Classe principale de l'application.
   */
  private static PApplet principale;
  
  /*
   * Gestionnaire Minim.
   */
  private static Minim minim;

  /*
   * Liste de sons associés à un nom.
   */
  private static HashMap<String,AudioPlayer> sons;

  /*
   * Le son est-il en sourdine ?
   */
  private static boolean sourdine;

  /**
   * Initialisation du gestionnaire sonore.
   * @param _principale La classe principale de l'application.
   */
  static void initialisation(PApplet _principale) { 
    principale = _principale;
    minim = new Minim(principale);
    reinitialiser();
  }

  /**
   * Réinitialiser la liste des sons.
   */
  static void reinitialiser() {
    sons = new HashMap<String,AudioPlayer>();
  }

  /**
   * Charger un son.
   * @param _nom Nom du son.
   * @param _chemin Chemin d'accès au son.
   */
  static void charger(String _nom, String _chemin) {
    /* Chargement du fichier sonore. */
    AudioPlayer son = minim.loadFile(_chemin);
    
    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, le son " + _chemin + " n'existe pas.");
      return;
    }

    /* Si le son est en sourdine. */
    if (sourdine) son.mute();

    /* Ajout du son à la liste. */
    sons.put(_nom, son);
  }

  /**
   * Jouer un son.
   * @param _nom Nom du son.
   */
  static void jouer(String _nom) {
    /* Rembobiner le son. */
    rembobiner(_nom);

    /* Récupération du son grâce à son nom. */
    AudioPlayer son = sons.get(_nom);

    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, aucun son n'existe pour " + _nom + ".");
      return;
    }

    /* Jouer le son. */
    son.play();
  }

  /**
   * Jouer un son en boucle.
   * @param _nom Nom du son.
   */
  static void boucle(String _nom) {
    /* Rembobiner le son. */
    rembobiner(_nom);

   /* Récupération du son grâce à son nom. */
    AudioPlayer son = sons.get(_nom);

    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, aucun son n'existe pour " + _nom + ".");
      return;
    }

    /* Jouer le son en boucle. */
    son.loop();
  }

  /**
   * Mettre un son en pause.
   * @param _nom Nom du son.
   */
  static void pause(String _nom) {
    /* Récupération du son grâce à son nom. */
    AudioPlayer son = sons.get(_nom);

    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, aucun son n'existe pour " + _nom + ".");
      return;
    }

    /* Mettre le son en pause. */
    son.pause();
  }

  /**
   * Rembobiner un son.
   * @param _nom Nom du son.
   */
  static void rembobiner(String _nom) {
    /* Récupération du son grâce à son nom. */
    AudioPlayer son = sons.get(_nom);

    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, aucun son n'existe pour " + _nom + ".");
      return;
    }

    /* Rembobiner le son. */
    son.rewind();
  }

  /**
   * Arrêter un son.
   * @param _nom Nom du son.
   */
  static void arreter(String _nom) {
    /* Récupération du son grâce à son nom. */
    AudioPlayer son = sons.get(_nom);

    /* Si le son n'existe pas. */
    if(son == null) {
      println("[Librairie]: Erreur dans le gestionnaire sonore, aucun son n'existe pour " + _nom + ".");
      return;
    }

    /* Mettre le son en pause. */
    son.pause();

    /* Rembobiner le son. */
    son.rewind();
  }
  
  /**
   * Arrêter tous les sons.
   */
  static void arreter() {
    /* Pour tous les sons. */
    for (AudioPlayer son: sons.values()) {
      /* Mettre le son en pause. */
      son.pause();

      /* Rembobiner le son. */
      son.rewind();
    }
  }
  
  /**
   * Mettre le son en sourdine.
   * @param _sourdine Activer ou désactiver la sourdine.
   */
  static void sourdine(boolean _sourdine) {
    sourdine = _sourdine;
    
    /* Pour tous les sons. */
    for (AudioPlayer son: sons.values()) {
      /* Si le son est en sourdine. */
      if(sourdine) { 
        son.mute();
      } else {
        son.unmute();
      }
    }
  }
}