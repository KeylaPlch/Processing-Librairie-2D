/**
 * Couche de niveau.
 */
abstract class CoucheNiveau {
  /**
   * Taille de la couche de niveau.
   */
  float largeur, hauteur;
  
  /**
   * Niveau propriétaire de la couche de niveau.
   */
  Niveau niveau;
  
  /**
   * Cadre d'affichage.
   */
  CadreAffichage cadre;

  /**
   * La couche de niveau est-elle standard ?
   */
  boolean nonstandard;

  /**
   * Coordonnées de la couche de niveau.
   * On utilise des coordonnées différentes pour pouvoir
   * manipuler la couche.
   */ 
  float translationX, translationY;

  /**
   * Echelle de la couche de niveau.
   * On utilise une échelle différente pour pouvoir
   * manipuler la couche.
   */
  float echelleX, echelleY;  

  /**
   * Liste des limites.
   */
  ArrayList<Limite> limites;

  /**
   * Couleur de fond.
   */
  color couleurFond;

  /**
   * Liste des éléments de fond.
   */
  ArrayList<Affichable> fond;
  
  /**
   * Liste des éléments de premier plan.
   */
  ArrayList<Affichable> premier_plan;

  /**
   * Liste des objets.
   */
  ArrayList<Objet> objets;

  /**
   * Liste des objets des interacteurs non joueurs.
   */
  ArrayList<Objet> objets_npc;

  /**
   * Liste des joueurs.
   */
  ArrayList<Joueur> joueurs;
  
  /**
   * Liste des interacteurs.
   */
  ArrayList<Interacteur> interacteurs;

  /**
   * Liste des interacteurs limités.
   */
  ArrayList<InteracteurLimite> interacteurs_limite;

  /**
   * Liste des autocollants.
   */
  ArrayList<Autocollant> autocollants;

  /**
   * Liste des déclencheurs.
   */
  ArrayList<Declencheur> declencheurs;

  /**
   * Modes de déboguage.
   */
  boolean deboguage;
  boolean afficherFond;
  boolean afficherLimites;
  boolean afficherObjets;
  boolean afficherAutocollants;
  boolean afficherInteracteurs;
  boolean afficherJoueurs;
  boolean afficherPremierPlan;
  boolean afficherDeclencheurs;
 
  /**
   * Constructeur simple.
   */
  CoucheNiveau(Niveau _niveau) {
    this(_niveau, _niveau.largeur, _niveau.hauteur);
  }

  /**
   * Constructeur complet.
   * @param _niveau Niveau propriétaire de la couche de niveau.
   * @param _largeur Largeur de la couche de niveau.
   * @param _hauteur Hauteur de la couche de niveau.
   */
  CoucheNiveau(Niveau _niveau, float _largeur, float _hauteur) {
    /* Définition de la taille. */
    largeur = _largeur;
    hauteur = _hauteur;

    /* Définition de l'échelle. */
    echelleX = 1;
    echelleY = 1;

    /* Définition du niveau propriétaire. */
    niveau = _niveau;
  
    /* Définition du cadre d'affichage. */
    cadre = _niveau.cadre;

    /* Définition de la couleur de fond comme transparente. */
    couleurFond = -1;

    /* Définition des modes de déboguage. */
    deboguage = true;
    afficherFond = true;
    afficherLimites = false;
    afficherObjets = true;
    afficherAutocollants = true;
    afficherInteracteurs = true;
    afficherJoueurs = true;
    afficherPremierPlan = true;
    afficherDeclencheurs = false;

    /* Initialisation des listes. */
    limites = new ArrayList<Limite>();
    fond = new ArrayList<Affichable>();
    premier_plan = new ArrayList<Affichable>();
    objets = new ArrayList<Objet>();
    objets_npc = new ArrayList<Objet>();
    joueurs = new ArrayList<Joueur>();
    interacteurs = new ArrayList<Interacteur>();
    interacteurs_limite = new ArrayList<InteracteurLimite>();
    autocollants = new ArrayList<Autocollant>();
    declencheurs = new ArrayList<Declencheur>();
  }

  /**
   * Constructeur plus complet.
   * @param _niveau Niveau propriétaire de la couche de niveau.
   * @param _largeur Largeur de la couche de niveau.
   * @param _hauteur Hauteur de la couche de niveau.
   * @param
   */
  CoucheNiveau(Niveau _niveau, float _largeur, float _hauteur, float _x, float _y, float _ex, float _ey) {
    this(_niveau, _largeur, _hauteur);

    /* Définition des coordonnées. */
    translationX = _x;
    translationY = _y;
    
    /* Définition de l'échelle. */
    echelleX = _ex;
    echelleY = _ey;

    /* Mise à l'échelle de la taille. */
    if(_ex != 1) { largeur /= _ex; largeur -= largeurEcran; }
    if(_ey != 1) { hauteur /= _ey; }

    /* Vérifier si la couche est standard. */
    nonstandard = (translationX != 0 || translationY != 0 || echelleX != 1 || echelleY != 1);
  }

  /**
   * Définir la couleur de fond.
   * @param _couleur Couleur de fond.
   */
  void definirCouleurFond(color _couleur) {
    couleurFond = _couleur;
  }

  /**
   * Ajouter une limite.
   * @param _limite Limite à ajouter.
   */
  void ajouterLimite(Limite _limite) {
    limites.add(_limite);
  }

  /**
   * Supprimer une limite.
   * @param _limite Limite à supprimer.
   */
  void supprimerLimite(Limite _limite) {
    limites.remove(_limite);
  }

  /** 
   * Supprimer toutes les limites.
   */
  void supprimerToutesLimites() {
    limites.clear();
  }

  /**
   * Ajouter une sprite de fond.
   * @param _affichable Sprite à ajouter.
   */
  void ajouterSpriteFond(Affichable _affichable) {
    fond.add(_affichable);
  }

  /**
   * Supprimer une sprite de fond.
   * @param _affichable Sprite à supprimer.
   */
  void supprimerSpriteFond(Affichable _affichable) {
    fond.remove(_affichable);
  }

  /**
   * Supprimer tous les éléments de fond.
   */
  void supprimerFond() {
    fond.clear();
  }

  /**
   * Ajouter une sprite de premier plan.
   * @param _affichable Sprite à ajouter.
   */
  void ajouterSpritePremierPlan(Affichable _affichable) {
    premier_plan.add(_affichable);
  }

  /**
   * Supprimer une sprite de premier plan.
   * @param _affichable Sprite à supprimer.
   */
  void supprimerSpritePremierPlan(Affichable _affichable) {
    premier_plan.remove(_affichable);
  }

  /**
   * Supprimer tous les éléments de premier plan.
   */
  void supprimerPremierPlan() {
    premier_plan.clear();
  }

  /**
   * Ajouter un autocollant.
   * @param _autocollant Autocollant à ajouter.
   */
  void ajouterAutocollant(Autocollant _autocollant) {
    autocollants.add(_autocollant);
  }

  /**
   * Supprimer un autocollant.
   * @param _autocollant Autocollant à supprimer.
   */
  void supprimerAutocollant(Autocollant _autocollant) {
    autocollants.remove(_autocollant);
  }

  /**
   * Supprimer tous les autocollants.
   */
  void supprimerToutAutocollants() {
    autocollants.clear();
  }

  /**
   * Ajouter un déclencheur.
   * @param _declencheur Déclencheur à ajouter.
   */
  void ajouterDeclencheur(Declencheur _declencheur) {
    declencheurs.add(_declencheur);
  }

  /**
   * Supprimer un déclencheur.
   * @param _declencheur Déclencheur à supprimer.
   */
  void supprimerDeclencheur(Declencheur _declencheur) {
    declencheurs.remove(_declencheur);
  }

  /**
   * Supprimer tous les déclencheurs.
   */
  void supprimerToutDeclencheurs() {
    declencheurs.clear();
  }

  /**
   * Ajouter un objet pour les joueurs seulement.
   * @param _objet Objet à ajouter.
   */
  void ajouterObjetJoueur(Objet _objet) {
    objets.add(_objet);
    attacher(_objet);
  }

  /**
   * Supprimer un objet pour les joueurs seulement.
   * @param _objet Objet à supprimer.
   */
  void supprimerObjetJoueur(Objet _objet) {
    objets.remove(_objet);
  }
  
  /**
   * Ajouter un objet pour les interacteurs non joueurs seulement.
   * @param _objet Objet à ajouter.
   */
  void ajouterObjetNPC(Objet _objet) {
    objets_npc.add(_objet);
    attacher(_objet);
  }

  /**
   * Supprimer un objet pour les interacteurs non joueurs seulement.
   * @param _objet Objet à supprimer.
   */
  void supprimerObjetNPC(Objet _objet) {
    objets_npc.remove(_objet);
  }

  /**
   * Supprimer tous les objets.
   */
  void supprimerToutObjets() {
    objets.clear();
    objets_npc.clear();
  }

  /**
   * Ajouter un interacteur.
   * @param _interacteur Interacteur à ajouter.
   */
  void ajouterInteracteur(Interacteur _interacteur) {
    interacteurs.add(_interacteur);
    attacher(_interacteur);
  }

  /**
   * Supprimer un interacteur.
   * @param _interacteur Interacteur à supprimer.
   */
  void supprimerInteracteur(Interacteur _interacteur) {
    interacteurs.remove(_interacteur);
  }
  
  /**
   * Ajouter un interacteur limité.
   * @param _interacteurLimite Interacteur limité à ajouter.
   */
  void ajouterInteracteurLimite(InteracteurLimite _interacteurLimite) {
    interacteurs_limite.add(_interacteurLimite);
    attacher(_interacteurLimite);
  }

  /**
   * Supprimer un interacteur limité.
   * @param _interacteurLimite Interacteur limité à supprimer.
   */
  void supprimerInteracteurLimite(InteracteurLimite _interacteurLimite) {
    interacteurs_limite.remove(_interacteurLimite);
  }  

  /**
   * Supprimer tous les interacteurs.
   */
  void supprimerToutInteracteurs() {
    interacteurs.clear();
    interacteurs_limite.clear();
  }

  /**
   * Ajouter un joueur.
   * @param _joueur Joueur à ajouter.
   */
  void ajouterJoueur(Joueur _joueur) {
    joueurs.add(_joueur);
    attacher(_joueur);
  }

  /**
   * Supprimer un joueur.
   * @param _joueur Joueur à supprimer.
   */
  void supprimerJoueur(Joueur _joueur) {
    joueurs.remove(_joueur);
  }

  /**
   * Supprimer tous les joueurs.
   */
  void supprimerToutJoueurs() {
    joueurs.clear();
  }

  /**
   * Actualiser un joueur.
   * @param _ancienJoueur Ancien joueur à remplacer.
   * @param _nouveauJoueur Nouveau joueur.
   */
  void actualiserJoueur(Joueur _ancienJoueur, Joueur _nouveauJoueur) {
    /* Récupération de la position de l'ancien joueur. */
    int position = joueurs.indexOf(_ancienJoueur);

    /* Si l'ancien joueur est dans la liste. */
    if (position > -1) {
      joueurs.set(position, _nouveauJoueur);
      _nouveauJoueur.limites.clear();
      attacher(_nouveauJoueur);
    }
  }

  /**
   * Attacher un élément à la couche de niveau.
   * @param _acteur Acteur à attacher.
   */
  void attacher(Acteur _acteur) {
    _acteur.definirCoucheNiveau(this);
  }
  
  /**
   * Nettoyer tous les objets éphémères.
   */
  void nettoyer() {
    nettoyerActeurs(interacteurs);
    nettoyerActeurs(interacteurs_limite);
    nettoyerActeurs(objets);
    nettoyerActeurs(objets_npc);
  }
  
  /**
   * Nettoyer une liste d'acteurs.
   * @param _acteurs Liste d'acteurs à nettoyer.
   */
  void nettoyerActeurs(ArrayList<? extends Acteur> _acteurs) {
    /* On parcours la liste d'acteurs à l'envers. */
    for (int i = _acteurs.size()-1; i >= 0; i--) {
      /* Si l'acteur n'est pas persistant. */
      if (!_acteurs.get(i).persistant) {
        _acteurs.remove(i);
      }
    }
  }
  
  /**
   * Supprimer tous les élements de la couche sauf le joueur.
   */
  void supprimerSaufJoueur() {
    supprimerFond();
    supprimerToutObjets();
    supprimerPremierPlan();
    supprimerToutesLimites();
    supprimerToutAutocollants();
    supprimerToutDeclencheurs();
    supprimerToutInteracteurs();    
  }

  /**
   * Supprimer tous les élements de la couche.
   */
  void supprimerTout() {
    supprimerSaufJoueur();
    supprimerToutJoueurs();
  }

  /**
   * Récupérer le niveau propriétaire de la couche.
   * @return Niveau propriétaire de la couche.
   */
  Niveau recupererNiveau() {
    return niveau;
  }

  /**
   * Récupérer le nombre d'acteurs de la couche.
   * @return Nombre d'acteurs de la couche.
   */
  int recupererNombreActeurs() {
    return joueurs.size() + interacteurs_limite.size() + interacteurs.size() + objets.size();
  }

  /**
   * Mapper une position "normale" à son équivalente dans la couche de niveau.
   * @param _x Coordonnée x "normale" à mapper.
   * @param _y Coordonnée y "normale" à mapper.
   * @return Coordonnées de la position dans la couche.
   */
  float[] mapperPosition(float _x, float _y) {
    float mx = (_x + translationX) * echelleX;
    float my = (_y + translationY) * echelleY;
    return new float[] {mx, my};
  }
  
  /**
   * Mapper une position de l'écran à son équivalente dans la couche de niveau.
   * @param _x Coordonnée x de l'écran à mapper.
   * @param _y Coordonnée y de l'écran à mapper.
   * @return Coordonnées de la position dans la couche.
   */
  float[] mapperPositionDepuisEcran(float _x, float _y) {
    float mx = map(_x/echelleX, 0, cadre.largeur, cadre.x, cadre.x + cadre.largeur);
    float my = map(_y/echelleY, 0, cadre.hauteur, cadre.y, cadre.y + cadre.hauteur);    
    return new float[] {mx, my};
  }

  /**
   * Mapper une position de la couche à son équivalente dans l'écran.
   * @param _x Coordonnée x de la couche à mapper.
   * @param _y Coordonnée y de la couche à mapper.
   * @return Coordonnées de la position dans l'écran.
   */
  float[] mapperPositionVersEcran(float _x, float _y) {
    float mx = (_x/echelleX - translationX);
    float my = (_y/echelleY - translationY);
    mx *= echelleX;
    my *= echelleY;
    return new float[] {mx, my};
  }

  /**
   * Récupérer les coordonnées relatives du pointeur de la souris,
   * par rapport à des coordonnées dans la couche de niveau fournies.
   * @param _x Coordonnée x de la couche fournie.
   * @param _y Coordonnée y de la couche fournie.
   * @param _mouseX Coordonnée x de la souris dans l'écran.
   * @param _mouseY Coordonnée y de la souris dans l'écran.
   * @return Les coordonnées relatives du pointeur.
   */
  float[] recupererInformationsSouris(float _x, float _y, float _mouseX, float _mouseY) {
    /* Mapper les coordonnées de la couche vers l'écran. */
    float[] mapper = mapperPositionVersEcran(_x, _y);
    float ax = mapper[0], ay = mapper[1];

    /* Mapper les coordonnées de la souris dans l'écran vers la couche. */
    mapper = mapperPositionDepuisEcran(_mouseX, _mouseY);
    float mx = mapper[0], my = mapper[1];

    /* Coordonnées relatives. */
    float dx = mx - ax;
    float dy = my - ay;

    /* Longueur du vecteur des coordonnées relatives. */
    float longueur = sqrt(dx*dx + dy*dy);

    return new float[] {dx, dy, longueur};
  }

  /**
   * Affichage de la couche de niveau.
   */
  void draw() {
    float x, y, largeur, hauteur;
    
    /* Récupération des coordonnées du cadre mappées dans la couche. */
    float[] mapper = mapperPosition(cadre.x, cadre.y);
    x = mapper[0];
    y = mapper[1];
    largeur = cadre.largeur / echelleX;
    hauteur = cadre.hauteur / echelleY;

    pushMatrix();

    /* Translation de la couche. */
    translate(cadre.x - x, cadre.y - y);
    scale(echelleX, echelleY);

    /* Affichage des éléments. */
    if (afficherFond) afficherFond(x, y, largeur, hauteur);
    if (afficherLimites) afficherLimites(x, y, largeur, hauteur);
    if (afficherObjets) afficherObjets(x, y, largeur, hauteur);
    if (afficherInteracteurs) afficherInteracteurs(x, y, largeur, hauteur);
    if (afficherJoueurs) afficherJoueurs(x, y, largeur, hauteur);
    if (afficherAutocollants) afficherAutocollants(x, y, largeur, hauteur);
    if (afficherPremierPlan) afficherPremierPlan(x, y, largeur, hauteur);
    if (afficherDeclencheurs) afficherDeclencheurs(x, y, largeur, hauteur);

    popMatrix();
  }

  /**
   * Afficher les éléments de fond.
   */
  void afficherFond(float _x, float _y, float _largeur, float _hauteur) { 
    /* Si la couleur de fond a été définie. */
    if (couleurFond != -1) {
      background(couleurFond);
    }

    /* Affichage de chaque élément. */
    for (Affichable element : fond) {
      element.draw(_x, _y, _largeur, _hauteur);
    }
  }

  /**
   * Afficher les limites.
   */
  void afficherLimites(float _x, float _y, float _largeur, float _hauteur) { 
    /* Affichage des limites. */
    for (Limite limite : limites) {
      limite.draw(_x, _y, _largeur, _hauteur);
    }

    /* Affichage des limites des interacteurs limités. */
    for (InteracteurLimite interacteur: interacteurs_limite) {
      /* Si les limites de l'interacteurs sont actives. */
      if (interacteur.limitation) {
        interacteur.afficherLimites(_x, _y, _largeur, _hauteur);
      }
    }
  }

  /**
   * Afficher les objets.
   */
  void afficherObjets(float _x, float _y, float _largeur, float _hauteur) { 
    /* Affichage des objets de joueur. */
    for (int i = objets.size()-1; i >= 0; i--) {
      Objet objet = objets.get(i);
      
      /* Si l'objet a été supprimé. */
      if (objet.supprimer) {
        objets.remove(i);
        continue;
      }

      /* Si l'objet est interactif et en mouvement. */
      if (objet.interactif && objet.mouvement && !objet.interactifJoueur) {
        /* Collision de l'objet avec les limites. */
        for (Limite limite : limites) {
          DetectionCollision.collision(limite, objet);
        }

        /* Pour chaque interacteur limité. */
        for (InteracteurLimite interacteur : interacteurs_limite) {
          /* Si les limites de l'interacteur sont actives. */
          if (interacteur.limitation) {
            /* Pour chaque limite de l'interacteur. */
            for (Limite limite : interacteur.limites) {
              DetectionCollision.collision(limite, objet);
            }
          }
        }
      }

      /* Pour chaque joueur. */
      for(Joueur joueur : joueurs) {
        /* Si le joueur n'est pas interactif. */
        if (!joueur.interactif) continue;

        /* Collision du joueur avec l'objet. */
        float[] collision = joueur.collision(objet);
        
        /* Si il y a collision. */
        if (collision != null) {
          objet.EvenementCollision(joueur);
          break;
        }
      }

      /* Affichage de l'objet. */
      objet.draw(_x, _y, _largeur, _hauteur);
    }

    /* Affichage des objets NPC. */
    for(int i = objets_npc.size()-1; i>=0; i--) {
      Objet objet = objets_npc.get(i);
      
      /* Si l'objet a été supprimé. */
      if (objet.supprimer) {
        objets_npc.remove(i);
        continue;
      }

      /* Si l'objet est interactif et en mouvement. */
      if(objet.interactif && objet.mouvement && !objet.interactifJoueur) {
        /* Collision de l'objet avec les limites. */
        for (Limite limite : limites) {
          DetectionCollision.collision(limite, objet);
        }

        /* Pour chaque interacteur limité. */
        for (InteracteurLimite interacteur: interacteurs_limite) {
          /* Si les limites de l'interacteur sont actives. */
          if (interacteur.limitation) {
            /* Pour chaque limite de l'interacteur. */
            for (Limite limite: interacteur.limites) {
              DetectionCollision.collision(limite, objet);
            }
          }
        }
      }

      /* Pour chaque interacteur. */
      for (Interacteur interacteur : interacteurs) {
        /* Si l'interacteur n'est pas interactif. */
        if (!interacteur.interactif) continue;

        /* Collision de l'interacteur avec l'objet. */
        float[] collision = interacteur.collision(objet);
        
        /* S'il y a collision. */
        if(collision != null) {
          objet.EvenementCollision(interacteur);
          break;
        }
      }

      /* Affichage de l'objet NPC. */
      objet.draw(_x, _y, _largeur, _hauteur);
    }
  }

  /**
   * Afficher les interacteurs.
   */
  void afficherInteracteurs(float _x, float _y, float _largeur, float _hauteur) {
    afficherInteracteurs(_x, _y, _largeur, _hauteur, interacteurs);
    afficherInteracteurs(_x, _y, _largeur, _hauteur, interacteurs_limite);
  }
  
  /**
   * Afficher les interacteurs dans une liste.
   * Afin d'éviter une duplication.
   */
  void afficherInteracteurs(float _x, float _y, float _largeur, float _hauteur, ArrayList<? extends Interacteur> _interacteurs) {
    /* Pour chaque interacteur de la liste. */
    for (int i = 0; i < _interacteurs.size(); i++) {
      Interacteur interacteur = _interacteurs.get(i);
      
      /* Si l'interacteur a été supprimé. */
      if (interacteur.supprimer) {
        _interacteurs.remove(i);
        continue;
      }

      /* Si l'objet est interactif et en mouvement. */
      if (interacteur.interactif && interacteur.mouvement && !interacteur.interactifJoueur) {
        /* Pour chaque limite. */
        for (Limite limite : limites) {
          DetectionCollision.collision(limite, interacteur);
        }

        /* Pour chaque interacteur limité. */
        for (InteracteurLimite interacteurLimite: interacteurs_limite) {
          /* Si l'interacteur limité est l'acteur en cours d'affichage. */
          if (interacteurLimite == interacteur) continue;
          
          /* Si les limites de l'interacteur limité sont actives. */
          if (interacteurLimite.limitation) {
            /* Pour chaque limite de l'interacteur limité. */
            for (Limite limite : interacteurLimite.limites) {
              DetectionCollision.collision(limite, interacteur);
            }
          }
        }
      }

      /* Affichage de l'interacteur. */
      interacteur.draw(_x, _y, _largeur, _hauteur);
    }
  }

  /**
   * Afficher les joueurs.
   */
  void afficherJoueurs(float _x, float _y, float _largeur, float _hauteur) {
    /* Pour chaque joueur. */
    for (int i = joueurs.size()-1; i >= 0; i--) {
      Joueur joueur = joueurs.get(i);

      /* Si le joueur a été supprimé. */
      if (joueur.supprimer) {
        joueurs.remove(i);
        continue;
      }

      /* Si le joueur est interactif. */
      if (joueur.interactif) {
        /* Si le joueur est en mouvement. */
        if (joueur.mouvement) {
          /* Pour chaque limite. */
          for (Limite limite : limites) {
            DetectionCollision.collision(limite, joueur);
          }

          /* Pour chaque interacteur limité. */
          for(InteracteurLimite interacteur : interacteurs_limite) {
            /* Si les limites de l'interacteur limité sont actives. */
            if(interacteur.limitation) {
              /* Pour chaque limite de l'interacteur limité. */
              for(Limite limite: interacteur.limites) {
                DetectionCollision.collision(limite, joueur);
              }
            }
          }
        }

        /* Si le joueur est actif. */
        if(!joueur.estDesactiver()) {
          /* Collision avec les interacteurs. */
          gererCollisionActeur(_x, _y, _largeur, _hauteur, joueur, interacteurs);
          gererCollisionActeur(_x, _y, _largeur, _hauteur, joueur, interacteurs_limite);
        }

        /* Pour chaque déclencheur. */
        for(int j = declencheurs.size()-1; j >= 0; j--) {
          Declencheur declencheur = declencheurs.get(j);

          /* Si le déclencheur a été supprimé. */
          if (declencheur.supprimer) { 
            declencheurs.remove(declencheur);
            continue;
          }

          /* Récupération des informations de collision. */
          float[] collision = declencheur.collision(joueur);
          
          /* S'il n'y a pas de collision. */
          if (collision == null && declencheur.desactiver) {
            declencheur.activer(); 
          }

          /* S'il y a collision. */
          else if(collision != null && !declencheur.desactiver) {
            /* Déclenchement. */
            declencheur.EvenementDeclencher(this, joueur, collision); 
          }
        }
      }

      /* Affichage du joueur. */
      joueur.draw(_x, _y, _largeur, _hauteur);
    }
  }
  
  /**
   * Vérifier les collisions entre un acteur est une liste d'interacteurs.
   * @param _acteur L'acteur à vérifier.
   * @param _interacteurs La liste d'interacteurs à vérifier.
   */
  void gererCollisionActeur(float _x, float _y, float _largeur, float _hauteur, Acteur _acteur, ArrayList<? extends Interacteur> _interacteurs) {
    /* Pour chaque interacteur dans la liste. */
    for (int i = 0; i < _interacteurs.size(); i++) {
      /* Récupération de l'interacteur. */
      Acteur interacteur = _interacteurs.get(i);
      
      /* Si l'interacteur n'est pas interactif. */
      if (!interacteur.interactif) continue;

      /* Récupération du tableau d'informations de collision. */
      float[] collision = _acteur.collision(interacteur);
      
      /* S'il y a collision. */
      if (collision != null) {
        /* Événement de collision de l'acteur. */
        _acteur.EvenementCollision(interacteur, collision);

        /* Taille du tableau d'informations de collision. */
        int taille = collision.length;
        
        /* Inversion des informations du tableau pour l'interacteur. */
        float[] inverse = new float[taille];
        arrayCopy(collision, 0, inverse, 0, taille);
        
        /* Pour toutes les informations. */
        for (int j = 0; j < taille; j++) {
          inverse[j] = -inverse[j];
        }

        /* Événement de collision de l'interacteur. */
        interacteur.EvenementCollision(_acteur, inverse); 
      }
      /* S'il s'agit d'un Traqueur. */
      else if (interacteur instanceof Traqueur) {
        ((Traqueur)interacteur).traquer(_acteur, _x, _y, _largeur, _hauteur);
      }
    }
  }

  /**
   * Afficher les autocollants.
   */
  void afficherAutocollants(float _x, float _y, float _largeur, float _hauteur) {
    /* Pour chaque autocollant. */
    for (int i = autocollants.size()-1; i >= 0; i--) {
      Autocollant autocollant = autocollants.get(i);

      /* Si l'autocollant a été supprimé. */
      if(autocollant.supprimer) {
        autocollants.remove(i);
        continue;
      }

      /* Affichage de l'autocollant. */
      autocollant.draw(_x, _y, _largeur, _hauteur);
    }
  }

  /**
   * Afficher les éléments de premier plan.
   */
  void afficherPremierPlan(float _x, float _y, float _largeur, float _hauteur) {
    /* Pour chaque élément de premier plan. */
    for (Affichable element: premier_plan) {
      /* Affichage de l'élement de premier plan. */
      element.draw(_x, _y, _largeur, _hauteur);
    }
  }

  /**
   * Afficher les déclencheurs.
   */
  void afficherDeclencheurs(float _x, float _y, float _largeur, float _hauteur) {
    /* Pour chaque déclencheur. */
    for (Affichable declencheur: declencheurs) {
      /* Affichage du déclencheur. */
      declencheur.draw(_x, _y, _largeur, _hauteur);
    }
  }

  //--------------------------//
  //        CONTROLES.        //
  //--------------------------//

  void keyPressed(char _touche, int _codeTouche) {
    for (Joueur joueur : joueurs) { joueur.keyPressed(_touche, _codeTouche); }
  }

  void keyReleased(char _touche, int _codeTouche) {
    for (Joueur joueur : joueurs) { joueur.keyReleased(_touche, _codeTouche); }
  }

  void mouseMoved(int _mouseX, int _mouseY) {
    for (Joueur joueur : joueurs) { joueur.mouseMoved(_mouseX, _mouseY); }
  }

  void mousePressed(int _mouseX, int _mouseY, int _bouton) {
    for (Joueur joueur : joueurs) { joueur.mousePressed(_mouseX, _mouseY, _bouton); }
  }

  void mouseDragged(int _mouseX, int _mouseY, int _bouton) {
    for (Joueur joueur : joueurs) { joueur.mouseDragged(_mouseX, _mouseY, _bouton); }
  }

  void mouseReleased(int _mouseX, int _mouseY, int _bouton) {
    for (Joueur joueur : joueurs) { joueur.mouseReleased(_mouseX, _mouseY, _bouton); }
  }

  void mouseClicked(int _mouseX, int _mouseY, int _bouton) {
    for (Joueur joueur : joueurs) { joueur.mouseClicked(_mouseX, _mouseY, _bouton); }
  }
}