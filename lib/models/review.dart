class Review {
  final String id;
  final int productId;
  final String autor;
  final int rating;
  final String titulo;
  final String comentario;
  final DateTime fecha;
  final int utiles;
  final List<String> fotos;

  Review({
    required this.id,
    required this.productId,
    required this.autor,
    required this.rating,
    required this.titulo,
    required this.comentario,
    required this.fecha,
    this.utiles = 0,
    this.fotos = const [],
  });

  Review copyWith({int? utiles}) => Review(
    id: id,
    productId: productId,
    autor: autor,
    rating: rating,
    titulo: titulo,
    comentario: comentario,
    fecha: fecha,
    utiles: utiles ?? this.utiles,
    fotos: fotos,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'autor': autor,
    'rating': rating,
    'titulo': titulo,
    'comentario': comentario,
    'fecha': fecha.toIso8601String(),
    'utiles': utiles,
    'fotos': fotos,
  };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    productId: json['productId'],
    autor: json['autor'],
    rating: json['rating'],
    titulo: json['titulo'],
    comentario: json['comentario'],
    fecha: DateTime.parse(json['fecha']),
    utiles: json['utiles'] ?? 0,
    fotos: List<String>.from(json['fotos'] ?? []),
  );
}
