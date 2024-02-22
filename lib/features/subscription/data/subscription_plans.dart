import 'package:blissful_marry/features/subscription/data/plan.dart';

final List<Plan> subscriptionPlans = [
  Plan(
    name: 'Plan De Baza',
    price: 'Gratuit',
    details: [
      'Urmarirea bugetului si gestionarea cheltuielilor de bază.',
      'Funcționalitate de luare a notițelor',
      'Gestionarea listei de invitați cu o limită de 30 de persoane.',
      'Aranjarea de locuri pentru până la 3 mese.'
    ],
  ),
  Plan(
    name: 'Plan Premium',
    price: '20 Lei',
    details: [
      'Instrumente avansate pentru buget și urmărire cheltuieli.',
      'Funcționalități îmbunătățite de luare a notițelor',
      'Gestionarea listei de invitați cu o limită de 80 de persoane',
      'Aranjament de locuri pentru până la 8 mese',
    ],
  ),
  Plan(
    name: 'Plan VIP',
    price: '35 Lei',
    details: [
      'Instrumente complete pentru buget',
      'Funcționalități avansate de luare a notițelor',
      'Gestionare detaliată a listei de invitați',
      'Planificare interactivă pentru aranjamentul locurilor.',
    ],
  ),
];
