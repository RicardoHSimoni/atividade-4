#  Aplicativo de Login com Splash, Onboarding e Temas no Flutter

## 🌟 Funcionalidades Principais
Um aplicativo Flutter que demonstra a implementação de:
- Splash Screen nativa e animada
- Onboarding informativo
- Tela de login funcional
- Suporte a tema claro e escuro
- Utilização de widget customizado reutilizáve

## Atualizações

- Mensagens de Login
- Mensagens de Registro
- Integração com Banco de Dados

## 🚀 Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu_usuario/dynamic_splash_onboarding.git
cd dynamic_splash_onboarding
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure a splash screen nativa (modo dia/noite):
```bash
flutter pub run flutter_native_splash:create
```

4. Execute o app:
 ```bash
flutter run
```

## 🎨 Splash Screen Inteligente

- Tema Dinâmico: Fundo automático dia/noite baseado no horário local
- Transição Suave: Animação personalizada usando Lottie
- Carregamento Otimizado: Integração nativa com flutter_native_splash

## 🚀 Fluxo Principal 

- Splash Nativo (2s)
- Exibição imediata com fundo contextual
- Verificação inicial de preferências
- Splash Animada (1.5s)
- Animação de entrada com fade-in
- Transição para onboarding/login
- Onboarding (3 telas)
- Apresentação interativa de recursos
- Navegação por gestos ou botões
- Persistência com shared_preferences
- Tela de Login
- Campos validados em tempo real
- Design responsivo
- Três opções de acesso

## ✨ Diferenciais

- Dynamic Background Widget: Fundo animado que reage ao contexto
- TimeContextController: Gerenciamento de tema baseado em horário
- CustomTextFormField: Campo de texto com validação integrada

## 📦 Dependências

- `flutter_native_splash`: Splash screen nativa
- `lottie`: Animações vetoriais
- `shared_preferences`:	Persistência de dados
- `provider`:	Gerenciamento de estado

## 🖼️ Screenshots

## 👥 Equipe
- Ana Cecilia De Morais
- Rebeca De Andrade Garcia
- Ricardo Henrique Simoni

## 📄 Licença
Este projeto está licenciado sob a Licença MIT 
