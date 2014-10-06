AlertaMX_iOS
============

Este repositorio incluye la propuesta de Smartplace S.A.P.I. de C.V. para el concurso de Retos Públicos: Reto AlertaMX (Entregable Fase 2, variante iOS: iPhone 5, 5s, iOS 7.0 o posterior) con una licencia Apache 2.0.

La aplicación incluye 4 secciones principales:

1. Alerta:
Despliega las alertas de la señal de Protocolo de Alerta Común (CAP) de los servicios dados de alta por Protección Civil. Se incluye por default el Servicio Meteorológico Nacional de la CONAGUA con información hidrometeorológica. Sin embargo, el sistema se comunica con un panel de control que le indica si existen CAPS nuevos disponibles y los descarga para mostrar al usuario. Es decir, es posible agregar/remover CAPs mediante un panel de control proporcionado a Protección Civil. 
La aplicación móvil detecta los cambios en los CAPs disponibles y hace los ajustes requeridos para mostrar la información al usuario.

2. Zonas de Riesgo:
Despliega la información contextual del Atlas Nacional de Riesgos del CENAPRED, la cual cuenta actualmente con 6 GeoJsons indicando información acerca de: (1) Zona regional de hundimientos y agretamientos, (2) Regiones susceptibles de deslizamientos, (3) Peligro por inundaciones a nivel municipal, (4) Zona de peligro por tsunamis lejanos y locales, (5) Volcanes activos y (6) Zona de peligro por caída de cenizas. Al igual que con la sección de Alertas, es posible agregar/remover GeoJsons del CENAPRED mediante un panel de control proporcionado a Protección Civil.

3. Familia:
La aplicación te permite solicitar ayuda a Protección Civil y tus familiares. También tus familiares y amigos pueden indicarte si necesitan ayuda durante una emergencia, o si se encuentran bien. En esta pantalla se despliega el estado de cada unos de tus familiares.

4. Instrucciones de Seguridad:
El objetivo de esta sección es proporcionar instrucciones sobre cómo reaccionar ante un desastre natural.

Otras funciones:

1. Notificaciones Push:
La aplicación recibe notificaciones push enviadas desde el panel de control proporcionado a Protección Civil (diferente repositorio para la aplicación web del panel de control).

2. Rescate:
La aplicación envía la localización del usuario al momento de solicitar ayuda.

NOTA:
Este repositorio contiene una versión prototipo en fase experimental sólamente. No se ha realizado una validación extensiva al mismo que permita garantizar su funcionamiento durante situaciones de peligro reales.
