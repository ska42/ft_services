<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clés secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur
 * {@link http://codex.wordpress.org/fr:Modifier_wp-config.php Modifier
 * wp-config.php}. C’est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'wordpress');

/** Utilisateur de la base de données MySQL. */
define('DB_USER', '__DB_USER__');

/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', '__DB_PASSWORD__');

/** Adresse de l’hébergement MySQL. */
define('DB_HOST', 'mysql');

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'J27p~XlMZL%[{xA+135ROHitqtHv?_MPY4)-!Hu`N@Ym3][|$&~_Xc*E.bk@wMX*');
define('SECURE_AUTH_KEY',  '8ydhI]oXc}tq~Ac3+N!eb{x.Yvn0<Uo{]Nu&+yPW~-K&!.A$!2eE5!naW$EF7loc');
define('LOGGED_IN_KEY',    'G!-%+gGr:LshyJ?=91pz^:}y3>mR#8#fFYry2_[c5@Zj|ESHzQnR+Mx5,5v2T^Io');
define('NONCE_KEY',        '+N<eh8_bSxjG~Oe+`.*PQ@#bgNkaojDT9h~0ALH9O*XIT,Vgj*:IykT=q|-+Wd_8');
define('AUTH_SALT',        'yzy|*qve]7ypvOxhh,-:0xg4`{!LHLI[,9^eD=Q!/%5.d?@01?f0Qz<u] .9:<o{');
define('SECURE_AUTH_SALT', 'M=Q%%+mil]MkUW=q-O4V[y`ti.Ws+%,VMp@>Q!<]!S6`8CBq&e~p5!oU`{-Si6t+');
define('LOGGED_IN_SALT',   '2~c+Q>V_|  s#[Dj8OLOCuJ%*q?09V(4r8,XPJwgk-DjNEzNA#|}~lvk<$hWbB:e');
define('NONCE_SALT',       '-aC|diqo~@3WUibW;cp+{(WMFGR3h[P~mz-Q*^uJJUK*zzs%Pa1@wHG.`f{X*&xk');
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortemment recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', true);

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');
