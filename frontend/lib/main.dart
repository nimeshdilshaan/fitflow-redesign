import 'package:flutter/material.dart';

void main() => runApp(const FitFlowApp());

// ============================================================
// THEME (colors taken from the FitFlow design image)
// ============================================================
class AppColors {
  static const bg = Color(0xFF12151F); // main background
  static const nav = Color(0xFF181A27); // bottom bar / top bar
  static const card = Color(0xFF1C212B); // cards
  static const cardAlt = Color(0xFF262C36); // icon circles, inner surfaces
  static const border = Color(0x1FFFFFFF); // subtle card border
  static const orange = Color(0xFFFFA11A); // CTA buttons
  static const orangeDark = Color(0xFFE8820C);
  static const yellow = Color(0xFFFCB618); // progress start / highlights
  static const green = Color(0xFF4CB82E); // progress end / logo green
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB4B8C5);
  static const textMuted = Color(0xFF7D8292);
  static const danger = Color(0xFFFF3B30);
}


BoxDecoration cardBox({double radius = 20, Color? color}) => BoxDecoration(
      color: color ?? AppColors.card,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.border),
    );

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitFlow',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.orange,
          onPrimary: Colors.black,
          secondary: AppColors.green,
          surface: AppColors.card,
          onSurface: AppColors.textPrimary,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.nav,
          indicatorColor: AppColors.green.withOpacity(0.18),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? Colors.white : AppColors.textSecondary,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? AppColors.green
                  : AppColors.textSecondary,
            );
          }),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.orange,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.orange,
            side: const BorderSide(color: AppColors.orange),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.green,
          circularTrackColor: AppColors.cardAlt,
        ),
      ),
      home: const FitFlowHome(),
    );
  }
}

// ============================================================
// SHELL
// ============================================================
class FitFlowHome extends StatefulWidget {
  const FitFlowHome({super.key});

  @override
  State<FitFlowHome> createState() => _FitFlowHomeState();
}

class _FitFlowHomeState extends State<FitFlowHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    WorkoutScreen(),
    NutritionScreen(),
    SocialScreen(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Nutrition',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Activity',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SHARED HEADER (logo + bell + avatar)
// ============================================================
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 38,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Text(
            'FitFlow',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_none,
                size: 30, color: AppColors.textSecondary),
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.danger,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.cardAlt,
          child: Icon(Icons.person, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      );
}

class _ScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _ScreenHeader(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(subtitle,
              style: const TextStyle(color: AppColors.textSecondary)),
        ],
      );
}

// ============================================================
// DASHBOARD
// ============================================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TopBar(),
          const SizedBox(height: 22),
          const Text('Welcome Back, Nimesh',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Ready to Work Out?',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
          const SizedBox(height: 20),

          // Today's goal
          Container(
            padding: const EdgeInsets.all(18),
            decoration: cardBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Today's Goal",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(height: 10, color: Colors.black38),
                      FractionallySizedBox(
                        widthFactor: 650 / 800,
                        child: Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.yellow, AppColors.green],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: '650',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFE9B0)),
                      ),
                      TextSpan(
                        text: ' / 800 CALS',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ]),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Stats row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: cardBox(),
            child: const IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: _MiniStat(
                          value: '52', unit: 'mins', label: 'Workout Time')),
                  VerticalDivider(color: AppColors.border, width: 1),
                  Expanded(
                      child: _MiniStat(
                          value: '8.2', unit: 'KM', label: 'Distance')),
                  VerticalDivider(color: AppColors.border, width: 1),
                  Expanded(
                      child:
                          _MiniStat(value: '9,450', unit: '', label: 'Steps')),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const _SectionTitle('Featured Workout'),
          const SizedBox(height: 12),

          // Featured workout
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF1C212B), Color(0xFF4A3010)],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Full Body HIIT',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('30 Mins  |  High Intensity',
                          style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [AppColors.orange, AppColors.orangeDark],
                          ),
                        ),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {},
                          child: const Text('Start Workout'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.fitness_center,
                    size: 80, color: Color(0x66FFA11A)),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SectionTitle('Popular Programs'),
              Row(children: [
                _Dot(active: false),
                _Dot(active: true),
                _Dot(active: false, small: true),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _ProgramCard(
                  title: 'Strength Builder',
                  weeks: '4',
                  icon: Icons.fitness_center,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ProgramCard(
                  title: 'Fat Burn Challenge',
                  weeks: '6',
                  icon: Icons.local_fire_department,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  const _MiniStat(
      {required this.value, required this.unit, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (unit.isNotEmpty)
              TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textSecondary)),
          ]),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;
  final bool small;
  const _Dot({required this.active, this.small = false});

  @override
  Widget build(BuildContext context) {
    final size = active ? 10.0 : (small ? 5.0 : 7.0);
    return Container(
      margin: const EdgeInsets.only(left: 6),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.textSecondary : AppColors.textMuted,
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final String title;
  final String weeks;
  final IconData icon;
  const _ProgramCard(
      {required this.title, required this.weeks, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3A2A1C), Color(0xFF1C212B)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Icon(icon, size: 52, color: const Color(0x88FFA11A)),
            ),
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: weeks,
                style: const TextStyle(
                    color: AppColors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const TextSpan(
                text: ' Weeks',
                style: TextStyle(color: AppColors.textSecondary)),
          ])),
        ],
      ),
    );
  }
}

// ============================================================
// WORKOUT
// ============================================================
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ScreenHeader('AI Workout', 'Your personalised training plan'),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1C212B), Color(0xFF4A3010)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.auto_awesome, color: AppColors.orange, size: 32),
                SizedBox(height: 15),
                Text("Today's AI Plan",
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Upper Body Strength',
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const _SectionTitle('Exercises'),
          const SizedBox(height: 15),
          const _ExerciseTile(
              number: '01',
              title: 'Push Ups',
              detail: '3 sets × 12 reps',
              icon: Icons.accessibility_new),
          const _ExerciseTile(
              number: '02',
              title: 'Shoulder Press',
              detail: '3 sets × 10 reps',
              icon: Icons.fitness_center),
          const _ExerciseTile(
              number: '03',
              title: 'Bicep Curls',
              detail: '3 sets × 12 reps',
              icon: Icons.sports_gymnastics),
          const _ExerciseTile(
              number: '04',
              title: 'Tricep Dips',
              detail: '3 sets × 10 reps',
              icon: Icons.airline_seat_recline_normal),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NUTRITION
// ============================================================
class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ScreenHeader('Nutrition', 'Track your meals and nutrition'),
          const SizedBox(height: 25),
          Center(
            child: SizedBox(
              width: 190,
              height: 190,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: 0.71,
                      strokeWidth: 16,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.cardAlt,
                      color: AppColors.green,
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1,420',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Text('of 2,000 kcal',
                          style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Row(
            children: [
              Expanded(
                  child: _MacroCard(
                      title: 'Protein', value: '92g', target: '120g')),
              SizedBox(width: 10),
              Expanded(
                  child:
                      _MacroCard(title: 'Carbs', value: '145g', target: '220g')),
              SizedBox(width: 10),
              Expanded(
                  child: _MacroCard(title: 'Fat', value: '48g', target: '65g')),
            ],
          ),
          const SizedBox(height: 28),
          const _SectionTitle("Today's Meals"),
          const SizedBox(height: 15),
          const _MealTile(
              icon: Icons.free_breakfast,
              title: 'Breakfast',
              meal: 'Oats & Banana',
              calories: '420 kcal'),
          const _MealTile(
              icon: Icons.lunch_dining,
              title: 'Lunch',
              meal: 'Chicken Rice Bowl',
              calories: '610 kcal'),
          const _MealTile(
              icon: Icons.dinner_dining,
              title: 'Dinner',
              meal: 'Grilled Chicken Salad',
              calories: '390 kcal'),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Log Meal'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SOCIAL
// ============================================================
class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ScreenHeader('Community', 'Share your fitness journey'),
          SizedBox(height: 22),
          _SocialPost(
            name: 'Alex Fernando',
            time: '12 min ago',
            title: 'Completed my morning workout! 💪',
            detail: 'Upper Body • 35 min • 320 kcal',
            likes: '24',
          ),
          _SocialPost(
            name: 'Sarah Wilson',
            time: '1 hour ago',
            title: '7 day streak completed! 🔥',
            detail: 'Consistency is the key to progress.',
            likes: '41',
          ),
          _SocialPost(
            name: 'Daniel Perera',
            time: '3 hours ago',
            title: 'New personal record!',
            detail: '5 km run completed in 27 minutes.',
            likes: '18',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROGRESS / ACTIVITY
// ============================================================
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ScreenHeader('My Progress', 'See how far you have come'),
          const SizedBox(height: 25),
          const Row(
            children: [
              Expanded(
                  child: _ProgressCard(
                      title: 'Weight',
                      value: '72.4',
                      unit: 'kg',
                      change: '-2.6 kg')),
              SizedBox(width: 12),
              Expanded(
                  child: _ProgressCard(
                      title: 'Workouts',
                      value: '18',
                      unit: 'this month',
                      change: '+24%')),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: cardBox(radius: 22),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Activity',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                SizedBox(height: 25),
                SizedBox(
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Bar(height: 80, label: 'Mon'),
                      _Bar(height: 130, label: 'Tue'),
                      _Bar(height: 100, label: 'Wed'),
                      _Bar(height: 155, label: 'Thu'),
                      _Bar(height: 120, label: 'Fri'),
                      _Bar(height: 165, label: 'Sat'),
                      _Bar(height: 65, label: 'Sun'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
              gradient: const LinearGradient(
                colors: [Color(0xFF1C212B), Color(0xFF4A3010)],
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.emoji_events, size: 42, color: AppColors.yellow),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('7 Day Streak!',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('Keep going and beat your record.',
                          style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REUSABLE WIDGETS
// ============================================================
class _ExerciseTile extends StatelessWidget {
  final String number;
  final String title;
  final String detail;
  final IconData icon;

  const _ExerciseTile({
    required this.number,
    required this.title,
    required this.detail,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: cardBox(radius: 18),
      child: Row(
        children: [
          Text(number,
              style: const TextStyle(
                  color: AppColors.orange, fontWeight: FontWeight.bold)),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: AppColors.cardAlt,
            child: Icon(icon, color: AppColors.orange, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(detail,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_outline, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String title;
  final String value;
  final String target;

  const _MacroCard(
      {required this.title, required this.value, required this.target});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: cardBox(radius: 18),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 7),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('/ $target',
              style:
                  const TextStyle(color: AppColors.textMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String meal;
  final String calories;

  const _MealTile({
    required this.icon,
    required this.title,
    required this.meal,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: cardBox(radius: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.cardAlt,
            child: Icon(icon, color: AppColors.green),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 3),
                Text(meal,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(calories,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.yellow)),
        ],
      ),
    );
  }
}

class _SocialPost extends StatelessWidget {
  final String name;
  final String time;
  final String title;
  final String detail;
  final String likes;

  const _SocialPost({
    required this.name,
    required this.time,
    required this.title,
    required this.detail,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.cardAlt,
                child: Icon(Icons.person, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(time,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 7),
          Text(detail, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.favorite_border,
                  size: 20, color: AppColors.orange),
              const SizedBox(width: 5),
              Text(likes),
              const SizedBox(width: 25),
              const Icon(Icons.chat_bubble_outline,
                  size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 5),
              const Text('Comment',
                  style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String change;

  const _ProgressCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Text(value,
              style:
                  const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
          Text(unit,
              style:
                  const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          Text(change,
              style: const TextStyle(
                  color: AppColors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final String label;

  const _Bar({required this.height, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.green, AppColors.yellow],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}