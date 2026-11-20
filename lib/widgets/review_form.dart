import 'package:material_ui/material_ui.dart';

import '../models/review.dart';

class ReviewForm extends StatefulWidget {
  final int productId;
  final ValueChanged<Review> onSubmit;

  const ReviewForm({
    super.key,
    required this.productId,
    required this.onSubmit,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _authorController = TextEditingController();
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();
  int _rating = 5;

  @override
  void dispose() {
    _authorController.dispose();
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      Review(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        productId: widget.productId,
        autor: _authorController.text.trim(),
        rating: _rating,
        titulo: _titleController.text.trim(),
        comentario: _commentController.text.trim(),
        fecha: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nueva reseña',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _authorController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Tu nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Ingresa tu nombre'
                    : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Calificación'),
                  const SizedBox(width: 12),
                  for (var value = 1; value <= 5; value++)
                    IconButton(
                      tooltip: '$value estrellas',
                      onPressed: () => setState(() => _rating = value),
                      icon: Icon(
                        value <= _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                ],
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _commentController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Comentario',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('Publicar reseña'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
