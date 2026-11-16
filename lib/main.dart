import 'dart:async';
import 'package:flutter/material.dart';

const roxo = Color(0xFF6B4EE8);

void main() => runApp(const StudyFlow());

// ---------- Dados (em memória; trocar por sqflite depois) ----------
class Atividade {
  String titulo, info;
  bool feita, prova;
  Atividade(this.titulo, this.info, {this.feita = false, this.prova = false});
}

class Materia {
  final String nome;
  final IconData icone;
  final Color cor;
  final List<Atividade> itens;
  Materia(this.nome, this.icone, this.cor, this.itens);
  int get provas => itens.where((a) => a.prova).length;
  int get atividades => itens.length - provas;
  double get progresso =>
      itens.isEmpty ? 0 : itens.where((a) => a.feita).length / itens.length;
}

final materias = <Materia>[
  Materia('Estrutura de Dados', Icons.storage, const Color(0xFF8B6CEF), [
    Atividade('Lista 1 - Exercícios', 'Entregue em 05/09', feita: true),
    Atividade('Lista 2 - Exercícios', 'Pendente'),
    Atividade('Trabalho em grupo', 'Entregue em 10/09', feita: true),
    Atividade('Prova 1', '21/09 · 14:00', prova: true),
  ]),
  Materia('Banco de Dados', Icons.dns, const Color(0xFF64A8FF), [
    Atividade('Lista 1 - Exercícios', 'Entregue em 08/09', feita: true),
    Atividade('Lista 2 - Exercícios', 'Pendente'),
    Atividade('Trabalho', 'Pendente'),
    Atividade('Prova 1', '05/10 · 10:00', prova: true),
  ]),
  Materia('Programação', Icons.code, const Color(0xFF5FCB9C), [
    Atividade('Lista 1 - Exercícios', 'Entregue em 05/09', feita: true),
    Atividade('Lista 2 - Exercícios', 'Entregue em 25/09', feita: true),
    Atividade('Trabalho em grupo', 'Entregue em 10/09', feita: true),
    Atividade('Prova 1', '18/10 · 16:00', prova: true),
  ]),
  Materia('Engenharia de Software', Icons.lightbulb_outline,
      const Color(0xFFFF9F4A), [
    Atividade('Lista 1 - Exercícios', 'Entregue em 05/09', feita: true),
    Atividade('Lista 2 - Exercícios', 'Pendente'),
    Atividade('Prova 1', '10/10 · 13:00', prova: true),
  ]),
  Materia('Sistemas Operacionais', Icons.desktop_windows,
      const Color(0xFFFF5C6C), []),
  Materia('Redes de Computadores', Icons.hub, const Color(0xFF14B8D4), []),
];

const tarefas = [
  ('Trabalho de Programação', 'Hoje · 20:00', 'Trabalho', Color(0xFF6B4EE8)),
  ('Estudar Banco de Dados', 'Amanhã · 14:00', 'Estudo', Color(0xFF38A9F5)),
  ('Leitura de Estrutura de Dados', '19/10 · 19:00', 'Leitura', Color(0xFFA48BE8)),
  ('Listas de Exercícios - BD', '20/10 · 20:00', 'Exercícios', Color(0xFFFF5FB8)),
  ('Projeto Final', '22/10 · 19:00', 'Projeto', Color(0xFFFF5C5C)),
];

// ---------- Helpers de UI ----------
OutlineInputBorder _borda() =>
    OutlineInputBorder(borderRadius: BorderRadius.circular(30));

Widget campo(String label, String hint, {bool senha = false}) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          obscureText: senha,
          decoration: InputDecoration(
              hintText: hint,
              border: _borda(),
              suffixIcon: senha ? const Icon(Icons.visibility_outlined) : null),
        ),
      ]),
    );

Widget combo(String label, String hint, List<String> op) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          hint: Text(hint),
          items: [for (final o in op) DropdownMenuItem(value: o, child: Text(o))],
          onChanged: (_) {},
          decoration: InputDecoration(border: _borda()),
        ),
      ]),
    );

Widget botao(String t, VoidCallback f) => SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: roxo,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        onPressed: f,
        child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
    );

void ir(BuildContext c, Widget w) =>
    Navigator.push(c, MaterialPageRoute(builder: (_) => w));

Widget titulo(String t) => Text(t, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold));

Widget iconeMateria(Materia m, {double s = 48}) => Container(
      width: s,
      height: s,
      decoration: BoxDecoration(color: m.cor, borderRadius: BorderRadius.circular(12)),
      child: Icon(m.icone, color: Colors.white, size: s * .6),
    );

// ---------- App ----------
class StudyFlow extends StatelessWidget {
  const StudyFlow({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
        title: 'StudyFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: roxo), useMaterial3: true),
        home: const Splash(),
      );
}

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login()));
      }
    });
  }

  @override
  Widget build(BuildContext c) => Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [roxo, Color(0xFFB8AAF2)])),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.school, size: 110, color: Colors.white),
            Text('StudyFlow',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 24),
            Text('Seu estudo,\nno seu ritmo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ]),
        ),
      );
}

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(28), children: [
            const Center(child: Icon(Icons.school, size: 70, color: roxo)),
            const Center(
                child: Text('StudyFlow',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: roxo))),
            const SizedBox(height: 24),
            const Text('Bem vindo de volta!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Faça login para continuar'),
            const SizedBox(height: 20),
            campo('E-mail', 'Seuemail@exemplo.com'),
            campo('Senha', 'Digite sua senha', senha: true),
            botao('Entrar', () => Navigator.pushReplacement(c, MaterialPageRoute(builder: (_) => const Shell()))),
            const Center(child: Padding(padding: EdgeInsets.all(12), child: Text('ou'))),
            OutlinedButton(onPressed: () => ir(c, const Cadastro()), child: const Text('Criar Conta')),
            TextButton(onPressed: () {}, child: const Text('Esqueceu sua senha?')),
          ]),
        ),
      );
}

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          titulo('Criar conta'),
          const Text('Preencha os dados abaixo para começar'),
          const SizedBox(height: 20),
          campo('Nome completo', 'Seu nome'),
          campo('E-mail', 'Seuemail@exemplo.com'),
          campo('Senha', 'Crie uma senha', senha: true),
          combo('Curso', 'Selecione seu curso',
              ['Ciência da Computação', 'Sistemas de Informação', 'Engenharia de Software']),
          combo('Semestre', 'Selecione seu semestre', [for (var i = 1; i <= 10; i++) '$iº semestre']),
          botao('Cadastrar', () => Navigator.pushAndRemoveUntil(
              c, MaterialPageRoute(builder: (_) => const Shell()), (r) => false)),
        ]),
      );
}

// ---------- Navegação principal ----------
class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext c) => Scaffold(
        body: SafeArea(
            child: [const Home(), const Materias(), const Tarefas(), const Calendario(), const Mais()][i]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: i,
          onDestinationSelected: (v) => setState(() => i = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Início'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Matérias'),
            NavigationDestination(icon: Icon(Icons.schedule), label: 'Tarefas'),
            NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Calendário'),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Mais'),
          ],
        ),
      );
}

class Home extends StatelessWidget {
  const Home({super.key});

  Widget _card(String t, String v, String s) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(v, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: roxo)),
          Text(s, style: const TextStyle(color: Colors.grey)),
        ]),
      );

  @override
  Widget build(BuildContext c) {
    final media = materias.map((m) => m.progresso).reduce((a, b) => a + b) / materias.length;
    return ListView(padding: const EdgeInsets.all(20), children: [
      titulo('Olá! 👋'),
      const Text('Que bom te ver por aqui!'),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: roxo, borderRadius: BorderRadius.circular(28)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Próximas tarefas',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          for (final t in tarefas.take(3))
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: const Icon(Icons.check_circle),
              title: Text(t.$1),
              subtitle: Text(t.$2),
            ),
        ]),
      ),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _card('Próximas provas', '2', 'nos próximos 30 dias')),
        const SizedBox(width: 12),
        Expanded(child: _card('Progresso geral', '${(media * 100).round()}%', 'das atividades')),
      ]),
      const SizedBox(height: 20),
      const Text('Minhas matérias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Row(children: [
        for (final m in materias.take(2))
          Expanded(
            child: GestureDetector(
              onTap: () => ir(c, MateriaPage(m)),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: m.cor.withOpacity(.12), borderRadius: BorderRadius.circular(24)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  iconeMateria(m, s: 40),
                  const SizedBox(height: 12),
                  Text(m.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${m.atividades} atividades', style: const TextStyle(color: Colors.grey)),
                ]),
              ),
            ),
          ),
      ]),
    ]);
  }
}

class Materias extends StatelessWidget {
  const Materias({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(20), children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          titulo('Minhas matérias'),
          const CircleAvatar(backgroundColor: roxo, child: Icon(Icons.add, color: Colors.white)),
        ]),
        const SizedBox(height: 12),
        TextField(
            decoration: InputDecoration(
                hintText: 'Buscar matéria...', prefixIcon: const Icon(Icons.search), border: _borda())),
        const SizedBox(height: 12),
        for (final m in materias)
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Colors.black45)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: iconeMateria(m),
              title: Text(m.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${m.atividades} atividades · ${m.provas} provas'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => ir(c, MateriaPage(m)),
            ),
          ),
      ]);
}

class MateriaPage extends StatefulWidget {
  final Materia m;
  const MateriaPage(this.m, {super.key});
  @override
  State<MateriaPage> createState() => _MateriaPageState();
}

class _MateriaPageState extends State<MateriaPage> {
  bool soProvas = false;

  void _adicionar() {
    final ctl = TextEditingController();
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Nova atividade'),
        content: TextField(controller: ctl, decoration: const InputDecoration(hintText: 'Título')),
        actions: [
          TextButton(
            onPressed: () {
              if (ctl.text.trim().isNotEmpty) {
                setState(() => widget.m.itens.add(Atividade(ctl.text.trim(), 'Pendente')));
              }
              Navigator.pop(d);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext c) {
    final m = widget.m;
    final lista = m.itens.where((a) => a.prova == soProvas).toList();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Row(children: [
          iconeMateria(m, s: 56),
          const SizedBox(width: 12),
          Expanded(child: Text(m.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: m.cor))),
        ]),
        const SizedBox(height: 16),
        Text('Progresso da matéria  ${(m.progresso * 100).round()}%'),
        const SizedBox(height: 6),
        LinearProgressIndicator(value: m.progresso, color: roxo, minHeight: 8, borderRadius: BorderRadius.circular(8)),
        const SizedBox(height: 16),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, label: Text('Atividades')),
            ButtonSegment(value: true, label: Text('Provas')),
          ],
          selected: {soProvas},
          onSelectionChanged: (s) => setState(() => soProvas = s.first),
        ),
        for (final a in lista)
          CheckboxListTile(
            value: a.feita,
            onChanged: (v) => setState(() => a.feita = v ?? false),
            title: Text(a.titulo),
            subtitle: Text(a.info),
          ),
        const SizedBox(height: 16),
        botao('Adicionar atividade', _adicionar),
      ]),
    );
  }
}

class Tarefas extends StatelessWidget {
  const Tarefas({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        floatingActionButton: const FloatingActionButton(
            onPressed: null, backgroundColor: roxo, child: Icon(Icons.add, color: Colors.white)),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          titulo('Tarefas'),
          const SizedBox(height: 8),
          const Wrap(spacing: 8, children: [
            Chip(label: Text('Pendentes')),
            Chip(label: Text('Em andamento')),
            Chip(label: Text('Concluídas')),
          ]),
          for (final t in tarefas)
            ListTile(
              leading: const Icon(Icons.radio_button_unchecked),
              title: Text(t.$1),
              subtitle: Text(t.$2),
              trailing: Chip(label: Text(t.$3, style: TextStyle(color: t.$4)), backgroundColor: t.$4.withOpacity(.15)),
            ),
        ]),
      );
}

class Calendario extends StatelessWidget {
  const Calendario({super.key});
  @override
  Widget build(BuildContext c) {
    const marcados = {4: Color(0xFFFFB3E0), 7: Color(0xFFFFA8A8), 17: Color(0xFFB8D4FF), 21: Color(0xFF8499C9)};
    Widget ev(String t, String h) => ListTile(leading: const Icon(Icons.access_time, color: roxo), title: Text(t), trailing: Text(h));
    return ListView(padding: const EdgeInsets.all(20), children: [
      titulo('Calendário'),
      const SizedBox(height: 12),
      const Text('SETEMBRO 2026', style: TextStyle(fontWeight: FontWeight.bold)),
      GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final d in 'DSTQQSS'.split('')) Center(child: Text(d, style: const TextStyle(color: Colors.grey))),
          const SizedBox(), const SizedBox(),
          for (var d = 1; d <= 30; d++)
            Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: marcados[d]),
              alignment: Alignment.center,
              child: Text('$d'),
            ),
        ],
      ),
      const Text('Hoje, 17 de Setembro', style: TextStyle(fontWeight: FontWeight.bold)),
      ev('Trabalho de Programação', '19:40'),
      ev('Reunião de grupo', '20:55'),
      const Text('Amanhã, 21 de Setembro', style: TextStyle(fontWeight: FontWeight.bold)),
      ev('Prova Estrutura de Dados', '14:00'),
    ]);
  }
}

class Mais extends StatelessWidget {
  const Mais({super.key});
  @override
  Widget build(BuildContext c) => ListView(padding: const EdgeInsets.all(20), children: [
        titulo('Mais'),
        ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Provas'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => ir(c, const Provas())),
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () => Navigator.pushAndRemoveUntil(
                c, MaterialPageRoute(builder: (_) => const Login()), (r) => false)),
      ]);
}

class Provas extends StatelessWidget {
  const Provas({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: AppBar(title: const Text('Provas')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          for (final m in materias)
            for (final p in m.itens.where((a) => a.prova))
              Card(
                child: ListTile(leading: iconeMateria(m), title: Text(m.nome), subtitle: Text(p.info)),
              ),
        ]),
      );
}
