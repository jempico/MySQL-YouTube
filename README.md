Comentarios:

- Tabla de relación many-to-many entre playlist y video creada.
- Tabla comment_like_dislike creada para tener un registro de los likes en comentarios. En esta tabla se establece una clave compuesta por 3 propiedades: ‘id_user’, ‘id_comment’ y ‘type’ (la cual’ distingue entre ‘like’ o ‘dislike’) para evitar duplicidades y restingir de esta manera que un usuario solo pueda hacer like o dislike una sola vez en cada comentario.
- Tabla video_like_dislike (anteriomente 'like_dislike') modificada para distinguirla de la anterior.
- Campo 'likes' en tabla 'Comment' eliminada.

