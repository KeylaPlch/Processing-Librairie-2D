/**
 * Auditeur de collision avec une limite.
 */
interface AuditeurCollisionLimite {
  /**
   * Événement de collision.
   * @param _limite Limite de la collision.
   * @param _acteur Acteur de la collision.
   * @param _intersection Tableau d'informations d'intersection.
   */
  void EvenementCollision(Limite _limite, Acteur _acteur, float[] _intersection);
}