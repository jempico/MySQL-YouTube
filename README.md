Comentarios:

- En la entidad like-dislike se establece una clave compuesta por  3 propiedades: ‘id_user’, ‘id_video’ y ‘type’ (la cual’ distingue entre ‘like’ o ‘dislike’) para evitar duplicidades  (un usuario solo puede hacer like o dislike una vez en cada video, pero puede cambiar su opinión y transformar un like por un dislike (y viceversa) en cualquier momento).

- En la tabla comment, un comentario puede recibir muchas respuestas, pero una respuesta solo puede ir dirigida a un único comentario (relación 1:n en una entidad autoenlazada)
