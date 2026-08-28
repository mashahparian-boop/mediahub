import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MediaHubApp());
}

class MediaHubApp extends StatefulWidget {
  const MediaHubApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MediaHubAppState? state = context.findAncestorStateOfType<_MediaHubAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MediaHubApp> createState() => _MediaHubAppState();
}

class _MediaHubAppState extends State<MediaHubApp> {
  Locale _locale = const Locale('fa');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediaHub - CityDigii',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('fa'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.vazirmatnTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    CreatePostScreen(),
    ChannelsScreen(),
    LogsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: isFa ? 'داشبورد' : 'Dashboard',
          ),
          NavigationDestination(
            icon: const Icon(Icons.post_add_outlined),
            selectedIcon: const Icon(Icons.post_add),
            label: isFa ? 'ارسال پست' : 'New Post',
          ),
          NavigationDestination(
            icon: const Icon(Icons.hub_outlined),
            selectedIcon: const Icon(Icons.hub),
            label: isFa ? 'کانال‌ها' : 'Channels',
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: isFa ? 'گزارش‌ها' : 'Logs',
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: isFa ? 'تنظیمات' : 'Settings',
          ),
        ],
      ),
    );
  }
}

// ---------------- Dashboard ----------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    return Scaffold(
      appBar: AppBar(
        title: Text(isFa ? 'داشبورد مدیریتی CityDigii' : 'CityDigii Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1E293B),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: Icon(Icons.laptop_chromebook, color: Colors.black),
                ),
                title: Text('CityDigii | شهر دیجیتال', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('citydigii.ir | @citydigii'),
                trailing: Icon(Icons.verified, color: Colors.cyan),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _statCard(isFa ? 'کانال‌های فعال' : 'Active Channels', '6', Icons.check_circle, Colors.green),
                  _statCard(isFa ? 'پست‌های ارسال‌شده' : 'Sent Posts', '24', Icons.send, Colors.cyan),
                  _statCard(isFa ? 'زمان‌بندی شده' : 'Scheduled', '3', Icons.schedule, Colors.orange),
                  _statCard(isFa ? 'وضعیت سیستم' : 'System Status', isFa ? 'آنلاین' : 'Online', Icons.wifi, Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF1E293B),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ---------------- Create Post ----------------
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _includeFooter = true;

  final String _defaultFooter = '''
---------------------------------
🌐 وب‌سایت: https://citydigii.ir
📞 تماس: ۰۹۱۲۲۹۶۵۰۴۲ - ۰۹۳۸۲۹۶۵۰۴۲
🆔 شبکه‌های اجتماعی: @citydigii
(ایتا، روبیکا، بله، اینستاگرام، تلگرام)
---------------------------------''';

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    return Scaffold(
      appBar: AppBar(title: Text(isFa ? 'ارسال پست جدید' : 'Create New Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: isFa ? 'عنوان پست' : 'Post Title',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: isFa ? 'متن محتوا' : 'Content',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text(isFa ? 'تزریق خودکار فوتر شهر دیجیتال' : 'Auto-inject CityDigii Footer'),
              value: _includeFooter,
              onChanged: (val) => setState(() => _includeFooter = val),
            ),
            if (_includeFooter)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_defaultFooter, style: const TextStyle(fontSize: 11, color: Colors.cyanAccent)),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.send),
              label: Text(isFa ? 'انتشار سراسری به همه شبکه‌ها' : 'Publish to All Channels'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFa ? 'پست با موفقیت در صف انتشار قرار گرفت ✅' : 'Post queued successfully ✅'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Channels ----------------
class ChannelsScreen extends StatelessWidget {
  const ChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    final channels = [
      {'name': 'ایتا (Eitaa)', 'id': '@citydigii', 'status': true},
      {'name': 'روبیکا (Rubika)', 'id': '@citydigii', 'status': true},
      {'name': 'بله (Bale)', 'id': '@citydigii', 'status': true},
      {'name': 'تلگرام (Telegram)', 'id': '@citydigii', 'status': true},
      {'name': 'اینستاگرام (Instagram)', 'id': '@citydigii', 'status': true},
      {'name': 'وب‌سایت (citydigii.ir)', 'id': 'API Connected', 'status': true},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(isFa ? 'اتصال کانال‌ها و شبکه‌ها' : 'Connected Channels')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: channels.length,
        itemBuilder: (context, index) {
          final item = channels[index];
          return Card(
            color: const Color(0xFF1E293B),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.cloud_done, color: Colors.green),
              title: Text(item['name'] as String),
              subtitle: Text(item['id'] as String, style: const TextStyle(color: Colors.grey)),
              trailing: Switch(value: item['status'] as bool, onChanged: (val) {}),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- Logs ----------------
class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    return Scaffold(
      appBar: AppBar(title: Text(isFa ? 'گزارش‌های انتشار' : 'Publishing Logs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _logTile('معرفی لپ‌تاپ لنوو LOQ', 'CityDigii Channels', 'ارسال موفق', Colors.green),
          _logTile('تخفیف ویژه لپ‌تاپ ایسوس ROG', 'CityDigii Channels', 'ارسال موفق', Colors.green),
          _logTile('بررسی لپ‌تاپ اچ‌پی Victus', 'Instagram / Telegram', 'ارسال موفق', Colors.green),
        ],
      ),
    );
  }

  Widget _logTile(String title, String channels, String status, Color color) {
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline, color: color),
        title: Text(title),
        subtitle: Text(channels, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ---------------- Settings ----------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isFa = Localizations.localeOf(context).languageCode == 'fa';
    return Scaffold(
      appBar: AppBar(title: Text(isFa ? 'تنظیمات برنامه' : 'Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFF1E293B),
            child: ListTile(
              leading: const Icon(Icons.language, color: Colors.cyan),
              title: Text(isFa ? 'تغییر زبان (Language)' : 'Switch Language'),
              subtitle: Text(isFa ? 'فارسی (فعال)' : 'English (Active)'),
              trailing: IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: () {
                  MediaHubApp.setLocale(
                    context,
                    isFa ? const Locale('en') : const Locale('fa'),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            color: Color(0xFF1E293B),
            child: ListTile(
              leading: Icon(Icons.business, color: Colors.cyan),
              title: Text('برند: شهر دیجیتال (CityDigii)'),
              subtitle: Text('سایت: citydigii.ir | تلفن: 09122965042'),
            ),
          ),
        ],
      ),
    );
  }
}
