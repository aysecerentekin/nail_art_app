// lib/features/nail/data/datasources/nail_remote_datasource.dart

import '../models/nail_design_model.dart';

abstract class NailRemoteDataSource {
  Future<List<NailDesignModel>> getNailDesigns();
  Future<NailDesignModel> getNailDesignById(String id);
}

class NailRemoteDataSourceImpl implements NailRemoteDataSource {
 

  @override
  Future<List<NailDesignModel>> getNailDesigns() async {
  
  
    await Future.delayed(const Duration(milliseconds: 800));  //sunucu gecikmesi olursa 800ms bekler
    return _mockDesigns;
  }

  @override
  Future<NailDesignModel> getNailDesignById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400)); //sunucu gecikmesi olursa 400ms bekler
    return _mockDesigns.firstWhere(
      (d) => d.id == id,
      orElse: () => throw Exception('Tasarım bulunamadı'),
    );
  }
}

final List<NailDesignModel> _mockDesigns = [ //arayüz için hazır veri.
  NailDesignModel(
    id: '1',
    title: 'Pembe Ombré',
    description:
        'Açık pembeden koyu pembeyeye geçişli, zarif ombré nail art tasarımı. Düğün ve özel davetler için mükemmel.',
    imageUrl: 'assets/images/pembe ombre.jpg',
    category: 'Ombre',
    colors: ['#FFB6C1', '#FF69B4', '#FF1493'],
    rating: 4.8,
    reviewCount: 324,
    difficulty: 'Orta',
    durationMinutes: 45,
    isFavorite: false,
    steps: [
      'Tırnaklarınızı şekillendirin ve taban kat uygulayın.',
      'Açık pembe oje ile tüm tırnağı boyayın ve kurumaya bırakın.',
      'Sünger yardımıyla orta pembeyi tırnağın ortasına uygulayın.',
      'Koyu pembeyi süngerle tırnağın ucuna vurarak geçiş oluşturun.',
      'Üst kat uygulayarak parlaklık katın.',
    ],
    artistName: 'Elif Nail Studio',
  ),
  NailDesignModel(
    id: '2',
    title: 'French Badem',
    description:
        'Klasik Fransız tırnağının modern yorumu. Badem form, ince beyaz uç ile şık ve zamansız bir görünüm.',
    imageUrl: 'assets/images/french badem.jpg',
    category: 'French',
    colors: ['#FFF5F5', '#FFFFFF', '#FFB6C1'],
    rating: 4.9,
    reviewCount: 512,
    difficulty: 'Zor',
    durationMinutes: 60,
    isFavorite: false,
    steps: [
      'Tırnaklarınızı badem şekline getirin ve taban kat uygulayın.',
      'Pudra pembesi oje ile tüm tırnağı boyayın.',
      'Beyaz oje ile ince bir fırça kullanarak uçlara ince çizgi çizin.',
      'İkinci kat pudra pembesi uygulayın.',
      'Şeffaf üst kat ile parlatın.',
    ],
    artistName: 'Selin Beauty',
  ),
  NailDesignModel(
    id: '3',
    title: 'Glitter Festival',
    description:
        'Holografik glitter ile ışıltılı festival tırnakları. Her ışıkta farklı renk yansımaları yaratır.',
    imageUrl: 'assets/images/glitter.jpg',
    category: 'Glitter',
    colors: ['#C0C0C0', '#FFD700', '#FF69B4', '#9B59B6'],
    rating: 4.7,
    reviewCount: 289,
    difficulty: 'Kolay',
    durationMinutes: 30,
    isFavorite: false,
    steps: [
      'Taban kat uygulayın ve kurumaya bırakın.',
      'Şeffaf jel veya yapıştırıcı oje sürün.',
      'Holografik glitter tozunu tırnağa bastırın.',
      'Fazla glitteri fırçayla alın.',
      '2-3 kat şeffaf üst kat uygulayarak sabitleyin.',
    ],
    artistName: 'Nails by Ayşe',
  ),
  NailDesignModel(
    id: '4',
    title: 'Floral Garden',
    description:
        'Pastel zemin üzerine el çizimi çiçekler. İlkbahar ve yaz ayları için taze ve feminen bir tasarım.',
    imageUrl: 'assets/images/floral garden.jpg',
    category: 'Floral',
    colors: ['#F8BBD0', '#E8F5E9', '#FFF9C4', '#FFFFFF'],
    rating: 4.6,
    reviewCount: 178,
    difficulty: 'Zor',
    durationMinutes: 90,
    isFavorite: false,
    steps: [
      'İnce beyaz veya krem oje ile zemin oluşturun.',
      'İnce nail art fırçası ile küçük çiçek merkezleri çizin.',
      'Her merkeze 5 küçük yaprak ekleyin.',
      'Yeşil oje ile ince yaprak ve dal detayları ekleyin.',
      'Şeffaf üst kat ile koruyun.',
    ],
    artistName: 'Zeynep Nail Art',
  ),
  NailDesignModel(
    id: '5',
    title: 'Geometrik Minimal',
    description:
        'Beyaz zemin üzerine altın geometrik çizgiler. Modern ve minimalist estetik sevenler için.',
    imageUrl: 'assets/images/geometrik minimal.jpg',
    category: 'Geometrik',
    colors: ['#FFFFFF', '#FFD700', '#000000'],
    rating: 4.5,
    reviewCount: 203,
    difficulty: 'Orta',
    durationMinutes: 50,
    isFavorite: false,
    steps: [
      'Beyaz oje ile 2 kat taban uygulayın.',
      'Bant yardımıyla geometrik alanları belirleyin.',
      'Altın oje ile bantlar arasını boyayın.',
      'Bantları dikkatli şekilde kaldırın.',
      'İnce fırçayla detayları temizleyin ve üst kat uygulayın.',
    ],
    artistName: 'Modern Nails Co.',
  ),
  NailDesignModel(
    id: '6',
    title: 'Lavanta Pastel',
    description:
        'Sakinleştirici lavanta tonlarında yumuşak pastel tırnaklar. Günlük kullanım için ideal.',
    imageUrl: 'assets/images/lavanta pastel.jpg',
    category: 'Pastel',
    colors: ['#E6E6FA', '#D8B4FE', '#C084FC'],
    rating: 4.7,
    reviewCount: 445,
    difficulty: 'Kolay',
    durationMinutes: 25,
    isFavorite: false,
    steps: [
      'Tırnaklarınızı düzeltin ve taban kat sürün.',
      'Açık lavanta oje ile iki kat uygulayın.',
      'Kurumadan önce pembe-mor sparkle ekleyebilirsiniz.',
      'Şeffaf üst kat ile bitirin.',
    ],
    artistName: 'Pastel Dreams Studio',
  ),
  NailDesignModel(
    id: '7',
    title: 'Kırmızı Klasik',
    description:
        'Hiç modası geçmeyen kırmızı ojeli klasik tırnak. Her ortama uygun, güçlü ve zarif.',
    imageUrl: 'assets/images/kırmızı klasik.jpg',
    category: 'Klasik',
    colors: ['#FF0000', '#C0392B'],
    rating: 4.9,
    reviewCount: 892,
    difficulty: 'Kolay',
    durationMinutes: 20,
    isFavorite: false,
    steps: [
      'Tırnaklarınızı temizleyin ve taban kat uygulayın.',
      'İnce bir fırçayla kırmızı ojeyi tutarlı biçimde sürün.',
      'İkinci kat uygulayın, kurumaya bırakın.',
      'Kenarları temizleyip şeffaf üst kat ile bitirin.',
    ],
    artistName: 'Classic Nails',
  ),
  NailDesignModel(
    id: '8',
    title: 'Akvaryum Jel',
    description:
        'Şeffaf jel içine küçük çiçek ve pullar hapsedilmiş büyüleyici akvaryum nail art tasarımı.',
    imageUrl: 'assets/images/akvaryum jel.jpg',
    category: 'Jel',
    colors: ['#TRANSPARENT', '#FFB6C1', '#87CEEB'],
    rating: 4.8,
    reviewCount: 267,
    difficulty: 'Zor',
    durationMinutes: 120,
    isFavorite: false,
    steps: [
      'UV jel taban kat uygulayın ve cure edin.',
      'İlk şeffaf jel katını uygulayın, cure etmeyin.',
      'Küçük çiçekler, pul ve glitterleri yerleştirin.',
      'İkinci şeffaf jel katını üzerine uygulayın.',
      'UV lambada 60 saniye cure edin ve üst kat ile bitirin.',
    ],
    artistName: 'Aquarium Nails TR',
  ),
];
