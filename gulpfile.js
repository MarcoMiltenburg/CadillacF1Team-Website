
/*******************************************************************************
** SETTINGS                                                                   **
*******************************************************************************/

var defaultDevelopmentServerHostName = '';              // Default development hostname


/*******************************************************************************
** DEPENDENCIES                                                               **
*******************************************************************************/

var gulp = require('gulp');
var gulpif = require('gulp-if');
var argv = require('minimist')(process.argv.slice(2));

var union = require('array-union');
var dateformat = require('dateformat');

var browsersync = require('browser-sync').create();

var ejs = require('gulp-ejs');
var sass = require('gulp-sass')(require('sass'));
var utf8 = require('gulp-utf8-convert');
var concat = require('gulp-concat');
var replace = require('gulp-replace');
var inject = require('gulp-inject-string');
var uglify = require('gulp-uglify');
var plumber = require('gulp-plumber');
var prefixer = require('gulp-autoprefixer');
var cleancss = require('gulp-clean-css');


/*******************************************************************************
** GLOBALS                                                                    **
*******************************************************************************/

var isProductionBuild = false;

var developmentServerHostName = '';
var reload = browsersync.reload;

var cleanCssSettings = {
	level: {
		1: {
			specialComments: '0'
		},
		2: {
			all: true
		}
	}
};


/*******************************************************************************
** FUNCTIONS                                                                  **
*******************************************************************************/

function isEnabled(s) {
    return (s && (s.length > 0) && ((s.toUpperCase() === 'TRUE') || (s.toUpperCase() === 'YES') || (s === '1')))
}

function plumberErrorHandler(err, plumber) {
    console.error('Error in file: ' + err.file);
    console.error('      at line: ' + err.line + ', column: ' + err.column);
    console.log(err.formatted);
    plumber.emit('end');
}


/*******************************************************************************
** FILE NAMES                                                                 **
*******************************************************************************/

var src_dir = 'src/';
var wwwroot_dir = 'wwwroot/';
var lib_dir = src_dir + 'lib/';

var css_dir = 'css/';
var js_dir = 'js/';
var img_dir = 'img/';
var favicons_dir = 'favicons/';
var html_dir = 'html/';
var incl_dir = 'includes/';

var files = {

    /* CSS */
    css: {

        main: {
            src : [lib_dir + 'normalize/normalize.css', src_dir + css_dir + 'general.scss', src_dir + css_dir + 'header.scss', src_dir + css_dir + 'footer.scss'],
            dest : 'main.css'
        },

        homepage: {
            src: [src_dir + css_dir + 'homepage-part1.scss', src_dir + css_dir + 'thumbnails.scss', src_dir + css_dir + 'homepage-part2.scss'],
            dest : 'homepage.css'
        },

        thumbnailsgrid: {
            src: [src_dir + css_dir + 'thumbnails.scss', src_dir + css_dir + 'pagenavigation.scss', src_dir + css_dir + 'thumbnailsgrid.scss'],
            dest : 'thumbnailsgrid.css'
        },

        view: {
            src: [src_dir + css_dir + 'thumbnails.scss', src_dir + css_dir + 'thumbnailsgrid.scss', src_dir + css_dir + 'pagenavigation.scss', src_dir + css_dir + 'view.scss'],
            dest : 'view.css'
        },

        download: {
            src: [src_dir + css_dir + 'download.scss'],
            dest : 'download.css'
        },

        login: {
            src: [src_dir + css_dir + 'login.scss'],
            dest : 'login.css'
        },

        adminold: {
            src : [src_dir + css_dir + 'admin-old.scss'],
            dest : 'admin-old.css'
        },

        dest : wwwroot_dir + css_dir
    },

    /* JS */
    js: {

        main: {
            src : [src_dir + js_dir + 'jquery-scrolllock.js', src_dir + js_dir + 'keyboard-shortcuts.js', src_dir + js_dir + 'navigation.js', src_dir + js_dir + 'downloadbasket.js', src_dir + js_dir + 'switchseason.js'],
            dest : 'main.js'
        },

        admin: {
            src : [src_dir + js_dir + 'admin.js', src_dir + js_dir + 'admin-old.js'],
            dest : 'admin.js'
        },

        dest : wwwroot_dir + js_dir
    },

    /* Favicons */
    favicons: {
        images: {
            src: [src_dir + favicons_dir + 'apple-touch-icon.png', src_dir + favicons_dir + 'favicon.svg', src_dir + favicons_dir + 'favicon-*.png', src_dir + favicons_dir + 'web-app-manifest-*.png'],
            dest: wwwroot_dir + img_dir + favicons_dir
        },
        rootfiles: {
            src: [src_dir + favicons_dir + 'favicon.ico', src_dir + favicons_dir + 'site.webmanifest'],
            dest : wwwroot_dir
        }
    },

    /* HTML Version */
    html: {
        version: {
            src : [src_dir + html_dir + 'version.asp'],
            dest : wwwroot_dir + incl_dir
        }
    }

};

var watch = {

    /* CSS */
    css: {
        main:           union(files.css.main.src,           [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss', src_dir + css_dir + 'logo.scss']),
        homepage:       union(files.css.homepage.src,       [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
        thumbnailsgrid: union(files.css.thumbnailsgrid.src, [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
        view:           union(files.css.view.src,           [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
        download:       union(files.css.download.src,       [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
        login:          union(files.css.login.src,          [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
        adminold:       union(files.css.adminold.src,       [src_dir + css_dir + 'theme-colours.scss', src_dir + css_dir + 'media-queries.scss']),
    }

}

/* Set release date to now */
var release_date = new Date();
var release_year = dateformat(release_date, 'yyyy');
var copyright_firstyear = '2025';

/* Read package file */
var package = require('./package.json');
var release = {
    version : package.version,
    datetime : dateformat(release_date, 'dddd, d mmmm yyyy, HH:MM:ss') + ' CET',
    datetimeraw : dateformat(release_date, 'yyyymmddHHMMss'),
    copyright : 'Copyright (c) ' + copyright_firstyear + (copyright_firstyear != release_year ? ('-' + release_year) : '') + ' Virtual Pages',
    package : package,
};


/*******************************************************************************
** CSS TASKS                                                                  **
*******************************************************************************/

const css_main = () => {
    return gulp.src(files.css.main.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.main.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_homepage = () => {
    return gulp.src(files.css.homepage.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.homepage.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_thumbnailsgrid = () => {
    return gulp.src(files.css.thumbnailsgrid.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.thumbnailsgrid.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_view = () => {
    return gulp.src(files.css.view.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.view.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_download = () => {
    return gulp.src(files.css.download.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.download.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_login = () => {
    return gulp.src(files.css.login.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.login.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}

const css_adminold = () => {
    return gulp.src(files.css.adminold.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(sass())
        .pipe(replace(/@charset \"utf-8\";/gi, ''))
        .pipe(prefixer({ cascade: false }))
        .pipe(concat(files.css.adminold.dest))
        .pipe(gulpif(isProductionBuild, cleancss(cleanCssSettings)))
        .pipe(inject.prepend('@charset "utf-8";\n'))
        .pipe(utf8())
        .pipe(gulp.dest(files.css.dest))
        .pipe(reload({ stream: true }));
}


/*******************************************************************************
** JS TASKS                                                                   **
*******************************************************************************/

const js_main = () => {
    return gulp.src(files.js.main.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(gulpif(isProductionBuild, uglify()))
        .pipe(concat(files.js.main.dest))
        .pipe(gulp.dest(files.js.dest))
        .pipe(reload({ stream: true }));
}

const js_admin = () => {
    return gulp.src(files.js.admin.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(gulpif(isProductionBuild, uglify()))
        .pipe(concat(files.js.admin.dest))
        .pipe(gulp.dest(files.js.dest))
        .pipe(reload({ stream: true }));
}


/*******************************************************************************
** FAVICON TASK                                                               **
*******************************************************************************/

const favicons = (done) => {
    gulp.src(files.favicons.images.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(gulp.dest(files.favicons.images.dest));

    gulp.src(files.favicons.rootfiles.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(gulp.dest(files.favicons.rootfiles.dest));

    done();
}


/*******************************************************************************
** HTML TASKS                                                                 **
*******************************************************************************/

const html_version = () => {
    return gulp.src(files.html.version.src)
        .pipe(plumber({ errorHandler: function (err) { plumberErrorHandler(err, this); } }))
        .pipe(ejs(release))
        .pipe(gulp.dest(files.html.version.dest));
}


/*******************************************************************************
** WATCH TASKS
*******************************************************************************/

const watch_css_main = () => {
    return gulp.watch(watch.css.main, gulp.series(css_main));
}

const watch_css_homepage = () => {
    return gulp.watch(watch.css.homepage, gulp.series(css_homepage));
}

const watch_css_thumbnailsgrid = () => {
    return gulp.watch(watch.css.thumbnailsgrid, gulp.series(css_thumbnailsgrid));
}

const watch_css_view = () => {
    return gulp.watch(watch.css.view, gulp.series(css_view));
}

const watch_css_download = () => {
    return gulp.watch(watch.css.download, gulp.series(css_download));
}

const watch_css_login = () => {
    return gulp.watch(watch.css.login, gulp.series(css_login));
}

const watch_css_adminold = () => {
    return gulp.watch(watch.css.adminold, gulp.series(css_adminold));
}

const watch_js_main = () => {
    return gulp.watch(files.js.main.src, gulp.series(js_main));
}

const watch_js_admin = () => {
    return gulp.watch(files.js.admin.src, gulp.series(js_admin));
}


/*******************************************************************************
** BROWSERSYNC TASK
*******************************************************************************/

const browser_sync = () => {
    browsersync.init({ proxy: developmentServerHostName, ghostMode: false });
}


/*******************************************************************************
** GULP TASKS                                                                 **
*******************************************************************************/

// Set up build task
const productionTask = (done) => {
    isProductionBuild = true;
    done();
}

// Set up development task
const developmentTask = (done) => {
    if (!(developmentServerHostName = (argv.devhostname ? argv.devhostname : defaultDevelopmentServerHostName))) {
        done(new Error('Specify development hostname using: --devhostname=<hostname>'));
    }
    done();
}

// Set up compile task with all compilation tasks
const compileTask = gulp.series(css_main, css_homepage, css_thumbnailsgrid, css_view, css_download, css_login, css_adminold, js_main, js_admin, favicons);

// Set up watch task
const watchTask = gulp.parallel(watch_css_main, watch_css_homepage, watch_css_thumbnailsgrid, watch_css_view, watch_css_download, watch_css_login, watch_css_adminold, watch_js_main, watch_js_admin);

// Set up serve task
const serveTask = gulp.parallel(browser_sync, watchTask);

// Set up build task
gulp.task('build', gulp.series(productionTask, html_version, compileTask));

// Set up default task
gulp.task('default', gulp.series(developmentTask, compileTask, serveTask));
