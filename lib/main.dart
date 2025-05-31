import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; // ✅ Optionnel pour launch avec string
import 'package:flutter/foundation.dart'; // ✅ Utile si besoin (pour debug ou web)

void main() {
  runApp(const UTSApp());
}

class UTSApp extends StatelessWidget {
  const UTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTS App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;
  bool _isNavBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isNavBarVisible) setState(() => _isNavBarVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isNavBarVisible) setState(() => _isNavBarVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> get _pages => [
        AccueilPage(scrollController: _scrollController),
        FilieresPage(scrollController: _scrollController),
        ConditionsPage(scrollController: _scrollController),
        AproposPage(scrollController: _scrollController),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 65, 114),
        elevation: 4,
        centerTitle: true,
        toolbarHeight: 30,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo1_uts.jpeg',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'Université Thomas Sankara',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1.5),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 24, 32, 41),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Accueil'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school), label: 'Filières'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assignment), label: 'Conditions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info), label: 'À propos'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  final ScrollController scrollController;

  const AccueilPage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      color: const Color(0xFFF5F5F5),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Bienvenue à l’Université Thomas Sankara",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF174172),
              ),
            ),
            const SizedBox(height: 20),
            _buildImageWithCaption(
              'assets/images/accueil1.jpg',
              '',
            ),
            const SizedBox(height: 20),
            const Text(
              "« L’esclave qui n’est pas capable d’assumer sa révolte ne mérite pas que l’on s’apitoie sur son sort. » – Thomas Sankara",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.5),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "L'Université Thomas Sankara est un pôle d'excellence de référence, produisant des cadres intègres, compétents, compétitifs et solidaires au service de la société, A travers ses infrastructures modernes et ses filières variées, l'univertité Thomas Sankara affirme sa vocation à servir la société burkinabè et au-delà.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: 24),
            const Text(
              "Aperçu de quelques instants et infrastructures emblématiques:",
              style: TextStyle(
                fontSize: 24,
                height: 1.5,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            isSmallScreen
                ? Column(
                    children: [
                      _buildImageWithCaption(
                        'assets/images/accueil.jpg',
                        "Monument de l’Université Thomas Sankara, symbole d’excellence et d’engagement.",
                      ),
                      _buildImageWithCaption(
                        'assets/images/monté_couleur.jpg',
                        "Université Thomas SANKARA : traditionnelle montée des couleurs nationales sous le signe de la normalisation des années académiques.",
                      ),
                      _buildImageWithCaption(
                        'assets/images/presidence.jpg',
                        "Présidence de l'université Thomas Sankara.",
                      ),
                      _buildImageWithCaption(
                        'assets/images/seg_bat.jpg',
                        "Bâtiment de l'UFR Sciences Économiques et de Gestion (SEG).",
                      ),
                      _buildImageWithCaption(
                        'assets/images/bloc.jpg',
                        "Bloc pédagogique avec salle de conférence et laboratoires modernes.",
                      ),
                      _buildImageWithCaption(
                        'assets/images/Td.jpg',
                        "Bloc de travaux dirigés.",
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/accueil.jpg',
                              "Monument de l’Université Thomas Sankara, symbole d’excellence et d’engagement.",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/monté_couleur.jpg',
                              "Université Thomas SANKARA : traditionnelle montée des couleurs nationales sous le signe de la normalisation des années académiques.",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/presidence.jpg',
                              "Présidence de l'université Thomas Sankara.",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/seg_bat.jpg',
                              "Bâtiment de l'UFR Sciences Économiques et de Gestion (SEG).",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/bloc.jpg',
                              "Bloc pédagogique avec salle de conférence et laboratoires modernes.",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildImageWithCaption(
                              'assets/images/Td.jpg',
                              "Bloc de travaux dirigés.",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    "Quelques statistiques",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      _StatCircle(label: "Étudiants", value: "+35000"),
                      _StatCircle(label: "UFR", value: "3"),
                      _StatCircle(label: "Instituts", value: "2"),
                      _StatCircle(label: "Restaurants", value: "2"),
                      _StatCircle(label: "Laboratoires", value: "4"),
                      _StatCircle(
                          label: "Enseignants-chercheurs", value: "+160"),
                      _StatCircle(label: "Personnels", value: "+180"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildImageWithCaption(String imagePath, String caption) {
    return _HoverImage(
      imagePath: imagePath,
      caption: caption,
    );
  }
}

class _HoverImage extends StatefulWidget {
  final String imagePath;
  final String caption;

  const _HoverImage({
    required this.imagePath,
    required this.caption,
  });

  @override
  State<_HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<_HoverImage> {
  bool _hovering = false;

  void _setHovering(bool hovering) {
    if (_hovering != hovering) {
      setState(() => _hovering = hovering);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS;

    Widget image = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      transform:
          _hovering ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: _hovering
            ? [
                BoxShadow(
                    color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          widget.imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Column(
      children: [
        isMobile
            ? GestureDetector(
                onTapDown: (_) => _setHovering(true),
                onTapUp: (_) => _setHovering(false),
                onTapCancel: () => _setHovering(false),
                child: image,
              )
            : MouseRegion(
                onEnter: (_) => _setHovering(true),
                onExit: (_) => _setHovering(false),
                child: image,
              ),
        const SizedBox(height: 8),
        Text(
          widget.caption,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _StatCircle extends StatelessWidget {
  final String label;
  final String value;

  const _StatCircle({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo,
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}

class FilieresPage extends StatelessWidget {
  final ScrollController scrollController;

  const FilieresPage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        title: const Text("Nos formations"),
        backgroundColor: Color.fromARGB(255, 137, 165, 197),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "L'université Thomas Sankara est constituée de trois (03) Unités de Formation et de Recherche (UFR), de deux (02) Instituts et d'une École doctorale :",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            _buildExpandableSection(
              title: "Unités de Formation et de Recherche (UFR)",
              items: [
                {
                  "name": "UFR Sciences Juridiques et Politiques (SJP)",
                  "details": [
                    "Licence (L3) en droit, option : droit privé et des affaires ;",
                    "Licence (L3) en droit, option : droit public;",
                    "Master en droit privé, option droit privé fondamental;",
                    "Master en droit public, option droit public fondamental;",
                    "Master en droit des affaires et fiscalité ;",
                    "Master en sciences politiques ;",
                    "Master en droit international public."
                  ]
                },
                {
                  "name": "UFR Sciences Economiques et de Gestion (SEG)",
                  "details": [
                    "Licence en économie de l’environnement et développement durable (EEDD);",
                    "Licence en sciences de gestion (LSG);",
                    "Licence en économie et gestion des entreprises et des organisations (EGEO);",
                    "Master en économie appliquée et en économie agricole;",
                    "Master en macro-économie appliquée et finances internationales (MAFI);",
                    "Master professionnel en analyse et suivi évaluation des politiques agricoles et alimentaires (MASPAA)."
                  ]
                },
                {
                  "name": "UFR Sciences Techniques (ST)",
                  "details": [
                    "Licence en mathématiques appliqués;",
                    "Licence en sytèmes d'informations et réseau;",
                    "Licence en analyse physico-chimique;",
                    "Licence en physique energétique et energies renouvelables;",
                    "Licence en hydrogéologie;",
                    "Licence en Ingénierie Mathématique Économie (LIME);",
                    "Licence en Ingénierie Statistique Économie (LISE);",
                    "Licence appliquée en Analyse Physico-Chimique;",
                    "Licence en Mathématiques et Applications;",
                    "Master en Ingénierie Statistique Économie;",
                    "Master en Ingénierie Mathématique Économie;",
                    "Master en mathématiques appliqués."
                  ]
                },
              ],
            ),
            _buildExpandableSection(
              title: "Instituts",
              items: [
                {
                  "name":
                      "Institut de Formations Ouverte et à Distance (IFOAD)",
                  "details": [
                    "Master  Professionnel en Management des Organisations et des Associations (M1  & M2 MOA) ;",
                    "Master Pro en développement local et gestion des collectivités territoriales  (M1 & M2 DEVLOG);",
                    "Master Pro en planification et gestion des structures éducatives en planification et gestion des structures éducatives (M1 & M2 MPGSE);",
                    "Certificat de compétences en informatique et Internet (2CI);",
                    "Certificat en suivi et évaluation de projets de développement (SEPRODEV);",
                    "Certificat en gestion d’entreprises innovantes (GEI);",
                    "Certificat concepteur de projets d’économie sociale et solidaire;",
                    "Certificat en gestion des structures éducatives (GSE)."
                  ]
                },
                {
                  "name":
                      "Institut Universitaire de Formation Initiale et Continue (IUFIC)",
                  "details": [
                    "Licence en sciences de gestion;",
                    "Licence professionnelle en sciencces politiques;",
                    "Master en management de projets;",
                    "Master en santé internationale;",
                    "Master en gestion de l'environnement;",
                    "Master en droit et politiques de l’environnement ;",
                    "Master en protection et droits de l’enfant;",
                    "Master en politique de développement et gestion des industries extractives;",
                    "Master en énergie renouvelable, développement et économie verte."
                  ]
                },
              ],
            ),
            _buildExpandableSection(
              title: "École doctorale",
              items: [
                {
                  "name": "École doctorale de l'Université Thomas Sankara",
                  "details": [
                    "Un encadrement scientifique assuré par les laboratoires ou les équipes de recherche reconnus;",
                    "Des formations utiles à la conduite de leurs projets de recherche et à l’élaboration de leurs projets professionnels."
                  ]
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required List<Map<String, dynamic>> items,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      children: items.map((item) {
        return ExpansionTile(
          title: Text(
            item["name"],
            style: const TextStyle(fontSize: 16),
          ),
          children: (item["details"] as List<String>).map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      detail,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class ConditionsPage extends StatelessWidget {
  final ScrollController scrollController;

  const ConditionsPage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F6FA),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📚 Conditions d’admission à l’Université Thomas Sankara",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF174172),
              ),
            ),
            const SizedBox(height: 16),
            _buildAdmissionCard(
              title: "🎓 Licence",
              description: "Accès en première année après le BAC.",
              conditions: [
                "Avoir le BAC ou un diplôme équivalent.",
                "Être inscrit sur la plateforme Campus Faso.",
              ],
              documents: [
                "Acte de naissance",
                "Relevés de notes du BAC",
                "Photos d’identité",
                "Diplôme du BAC",
              ],
              color: Colors.lightBlue[50],
            ),
            _buildAdmissionCard(
              title: "🎓 Master",
              description: "Formation de spécialisation après la Licence.",
              conditions: [
                "Être titulaire d'une Licence (LMD) ou d'un diplôme équivalent dans le domaine concerné.",
                "Avoir obtenu une moyenne minimale de 12/20 en Licence.",
              ],
              documents: [
                "Une demande manuscrite adressée au Président de l'UTS.",
                "Des copies légalisées des diplômes et relevés de notes.",
                "Un curriculum vitae.",
                "Une lettre de motivation.",
                "Le reçu de paiement des frais de dossier (15 000 FCFA).",
              ],
              color: Colors.green[50],
            ),
            _buildAdmissionCard(
              title: "🎓 Doctorat",
              description: "Cycle de recherche après le Master.",
              conditions: [
                "Être titulaire d'un Master Recherche ou d'un diplôme équivalent avec une moyenne minimale de 12/20.",
                "Obtenir l'accord écrit d'un Enseignant-Chercheur de rang A, membre d'un laboratoire affilié à l'École Doctorale de l'UTS, pour l'encadrement de la thèse.",
              ],
              documents: [
                "Une copie légalisée de l'acte de naissance.",
                "Le plan détaillé des études antérieures.",
                "Les copies légalisées des diplômes et relevés de notes.",
                "Un curriculum vitae.",
                "Une lettre de motivation.",
                "Un projet de recherche d'au moins 5 pages.",
                "L'accord écrit de l'encadrant et, le cas échéant, d'un co-directeur habilité.",
                "Un certificat de nationalité."
              ],
              color: Colors.orange[50],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionCard({
    required String title,
    required String description,
    required List<String> conditions,
    required List<String> documents,
    Color? color,
  }) {
    return Card(
      color: color ?? Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF174172))),
            const SizedBox(height: 8),
            Text(description,
                style: const TextStyle(fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 16),
            const Text("Conditions d’accès :",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            ...conditions.map((c) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• "),
                      Expanded(child: Text(c)),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            const Text("Documents requis :",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            ...documents.map((d) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• "),
                      Expanded(child: Text(d)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class AproposPage extends StatelessWidget {
  final ScrollController scrollController;

  const AproposPage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos de nous"),
        backgroundColor: Color.fromARGB(255, 139, 166, 197),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SectionTitle("Historique"),
            SectionText(
              "L'université Ouaga II a été créée par décret le 12 décembre 2007, sa construction a débuté en 2008. Le siège de l'université est situé dans la commune de Saaba, à une vingtaine de kilomètres de Ouagadougou. Cette institution universitaire a été créée dans le but de désengorger l'université de Ouagadougou, "
              "L'université Ouaga II (UO2) a été érigée en Établissement Public de l’Etat à caractère Scientifique, Culturel et Technique (EPESCT) par décret n° 2008- 442/PRES/PM/MESSRS/MEF du 15 juillet 2008. C’est également par décret n° 2008-516/PRES/PM/MESSRS/MEF du 28 août 2008 que les statuts de l'université Ouaga II ont été adoptés. Ces statuts définissent les missions, l’organisation et le fonctionnement, elle a pour objectif de contribuer à la résolution des problèmes d'offre de formation et de recherche au Burkina Faso. Cette université a été constituée sur la base des Unités de formation et de recherche (UFR) de sciences économiques et gestion (SEG) et de sciences juridiques et politiques (SJP), faisant anciennement partie de l'université Ouaga 1, Pr Joseph Ki-Zerbo.",
            ),
            SizedBox(height: 20),
            SectionTitle("Présentation"),
            SectionText(
              "L'université Thomas-Sankara est une université publique d'Afrique de l'Ouest actuellement située à l'est de la ville de Ouagadougou, la capitale du Burkina Faso. Elle était anciennement nommée université Ouaga II (UO2) mais elle a été rebaptisée et inaugurée le 15 octobre 2020 par le Premier ministre Christophe Dabiré en l'honneur de l'ancien président Thomas Sankara.",
            ),
            SizedBox(height: 20),
            SectionTitle("Site"),
            SectionText(
              "L'université Thomas Sankara s’étend sur une superficie de 2111 ha, situé à une vingtaine de kilomètres du centre-ville de Ouagadougou, dans la commune rurale de Saaba, sur la route nationale 4 (RN4). Le site, en construction, abrite déjà un bâtiment R+2 à usage pédagogique, deux pavillons de 2500 places chacun et un amphi jumelé de 2500 équipés en matériel de visioconférence et une cité universitaire de 408 lits.",
            ),
            SizedBox(height: 20),
            SectionTitle("Plus d'infos"),
            InteractiveLink(
              text: "📞 Téléphone : +226 25 36 99 60",
              uri: 'tel:+22625369960',
            ),
            InteractiveLink(
              text: "🌐 Site web : Wikipedia UTS",
              uri:
                  'https://fr.wikipedia.org/wiki/Universit%C3%A9_Thomas-Sankara',
            ),
            InteractiveLink(
              text: "🌐 Site web : www.uts.bf",
              uri: 'https://www.uts.bf',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF174172),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;
  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, height: 1.5),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class InteractiveLink extends StatefulWidget {
  final String text;
  final String uri;

  const InteractiveLink({required this.text, required this.uri, super.key});

  @override
  State<InteractiveLink> createState() => _InteractiveLinkState();
}

class _InteractiveLinkState extends State<InteractiveLink> {
  bool _isHovering = false;

  void _launchUri() async {
    final uri = Uri.parse(widget.uri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // ✅ Corrigé ici
    } else {
      throw 'Impossible d\'ouvrir ${widget.uri}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: _launchUri,
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: _isHovering ? Colors.blue : Colors.black,
              decoration:
                  _isHovering ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
