import 'package:flutter/material.dart';
import 'package:projeto_integrador/componentes/decoracao_campo_autenticacao.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  bool _senhaVisivel = false;
  bool _confirmarSenhaVisivel = false;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  //Variáveis para o comboBoxes
  String? selectedSexo;
  String? selectedTipoUsuario;
  String? selectedTipoDoencaCronica;

  //Listas para os ComboBoxes
  final List<String> _sexo = [
    "Masculino",
    "Feminino",
  ];

  final List<String> _usuario = ["Pessoa Portadora de doença crônica"];

  final List<String> _opcaoDoenca = [
    "Diabetes",
    "Hipertenção",
    "Colesterol Alto",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              //comando que permite rolar a tela para cima e para baixo
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/logo.png", height: 128),
                  const Text(
                    "Saúde Para todos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible:
                        !queroEntrar, // Apenas visível quando queroEntrar é falso (Cadastro)
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: getAuthenticationInputDecoration("Nome"),
                          controller: _nomeController,
                          validator: (String? value) {
                            if (!queroEntrar) {
                              // Valida apenas se estiver no modo de Cadastro
                              if (value == null || value.isEmpty) {
                                return "Por favor, digite seu Nome";
                              }
                              if (value.length < 5) {
                                return "O Nome é muito curto";
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: getAuthenticationInputDecoration("E-Mail"),
                    controller: _emailController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira um endereço de E-mail";
                      }
                      if (value.length < 5) {
                        return "O E-mail é muito curto";
                      }
                      if (!value.contains("@")) {
                        return "O E-mail não é válido!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration:
                        getAuthenticationInputDecoration("Senha").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _senhaVisivel
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _senhaVisivel = !_senhaVisivel;
                          });
                        },
                      ),
                    ),
                    controller: _senhaController,
                    obscureText: !_senhaVisivel,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, digite uma senha";
                      }
                      if (value.length < 8) {
                        return "A senha deve ter pelo menos 8 caracteres";
                      }
                      //Usados para criação de um padrão de senha
                      bool contemMaiscula = value.contains(RegExp(r'[A-Z]'));
                      bool contemMinuscula = value.contains(RegExp(r'[a-z]'));
                      bool contemNumeros = value.contains(RegExp(r'[0-9]'));
                      bool contemCaracteresEspeciais =
                          value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

                      if (!contemMaiscula) {
                        return "A senha deve conter pelo menos uma letra maiúscula.";
                      }
                      if (!contemMinuscula) {
                        return "A senha deve conter pelo menos uma letra minúscula.";
                      }
                      if (!contemNumeros) {
                        return "A senha deve conter pelo menos um número.";
                      }
                      if (!contemCaracteresEspeciais) {
                        return "A senha deve conter pelo menos um caractere especial (!@#\$%^&*...).";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: !queroEntrar,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _confirmarSenhaController,
                          decoration: getAuthenticationInputDecoration(
                                  "Confirme a Senha")
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmarSenhaVisivel
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmarSenhaVisivel =
                                      !_confirmarSenhaVisivel;
                                });
                              },
                            ),
                          ),
                          obscureText: !_confirmarSenhaVisivel,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, confirme sua senha.";
                            }
                            if (value != _senhaController.text) {
                              return "As senhas não coincidem!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownButton(
                          hintText: 'Selecione seu Sexo',
                          value: selectedSexo,
                          options: _sexo,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSexo = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownButton(
                          hintText: "Qual tipo de usuário você é?",
                          value: selectedTipoUsuario,
                          options: _usuario,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTipoUsuario = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildDropdownButton(
                          hintText: "Qual doença crônica você possui?",
                          value: selectedTipoDoencaCronica,
                          options: _opcaoDoenca,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTipoDoencaCronica = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      botaoPrincipalClicado();
                      // Lógica do botão
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Estilo solicitado: fundo branco, texto azul, borda azul
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (queroEntrar) ? "Entrar" : "Cadastrar",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus(); // Esconde o teclado

                      // Limpar os campos ANTES de alterar o estado e reconstruir
                      _nomeController.clear();
                      _emailController.clear();
                      _senhaController.clear();
                      _confirmarSenhaController.clear();
                      selectedSexo = null;
                      selectedTipoUsuario = null;
                      selectedTipoDoencaCronica = null;

                      // Agora, atualiza o estado para reconstruir a UI
                      setState(() {
                        queroEntrar = !queroEntrar;
                        // Reseta o estado de validação do formulário
                        _formKey.currentState?.reset();
                        // Resetar a visibilidade da senha ao alternar modos
                        _senhaVisivel = false;
                        _confirmarSenhaVisivel = false;
                      });
                    },
                    child: Text(
                        style: const TextStyle(color: Colors.blue),
                        (queroEntrar)
                            ? "Ainda não tem uma conta? Cadastre-se!"
                            : "Já tem uma conta? Entre"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Função chamada ao clicar no botão principal
  botaoPrincipalClicado() {
    if (_formKey.currentState!.validate()) {
      print("Form válido");
      // Adicione aqui a lógica de login ou cadastro
      if (queroEntrar) {
        print(
            "Tentando entrar com E-mail: ${_emailController.text} e Senha: ${_senhaController.text}");
        // Exibe SnackBar de sucesso para Login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login realizado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print(
            "Tentando cadastrar com Nome: ${_nomeController.text}, E-mail: ${_emailController.text}, Senha: ${_senhaController.text}, Sexo: $selectedSexo, Tipo Usuário: $selectedTipoUsuario, Doença Crônica: $selectedTipoDoencaCronica");
        // Exibe SnackBar de sucesso para Cadastro
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cadastro realizado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      print("Form inválido");
      // Opcional: Exibir SnackBar de erro se o formulário for inválido
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, preencha todos os campos corretamente."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildDropdownButton({
    required String hintText,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hintText),
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.blue,
        ),
      ),
    );
  }
}
