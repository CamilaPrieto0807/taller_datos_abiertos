# taller_datos_abiertos

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## Publicación con Firebase App Distribution

Flujo: Generar APK → App Distribution → Testers → Instalación → Actualización

1. Subir la versión en `pubspec.yaml` (ej. `version: 1.0.1+2`; 1.0.1 es el versionName y 2 el versionCode, que siempre debe aumentar).
2. Hacer commit y push. El workflow `Build APK` (GitHub Actions) ejecuta `flutter build apk --release`.
3. En GitHub → Actions, descargar el artefacto `app-release` y extraer `app-release.apk`.
4. En Firebase Console → App Distribution → Versiones, arrastrar el APK.
5. Asignar el grupo `QA_Clase` (incluye dduran@uceva.edu.co), pegar las release notes y pulsar Distribuir.
6. Los testers reciben el correo, aceptan la invitación e instalan; para actualizar, abren el enlace o Firebase App Tester y pulsan Actualizar.

### Formato de release notes
Versión X.Y.Z (código) - fecha / Responsable / Cambios / Credenciales de prueba / Qué probar.

### Versionado
1.0.0+1 → 1.0.1+2