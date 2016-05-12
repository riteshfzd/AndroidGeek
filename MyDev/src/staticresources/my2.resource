@CHARSET "ISO-8859-1";
body{
padding-top: 0px;
font-family: Gotham;
background: #d6d6d6 url(../img/background.png) repeat-x center top;
background-color:#d6d6d6 !important;
}

.starter-template {
  padding: 40px 15px;
  text-align: center;
}

.container{
background-color: white;
}

@font-face
{
font-family: 'Gotham';
src: url('../fonts/Gotham-Light.eot');
src: url('../fonts/Gotham-Light.eot?#iefix') format('embedded-opentype'), url('../fonts/Gotham-Light.woff')format('woff'), url('../fonts/Gotham-Light.otf')format('opentype'), url('../fonts/Gotham-Light.svg')format('svg');
font-weight: 300;
}

@font-face
{
font-family: 'Gotham';
src: url('../fonts/Gotham-Book.woff')format('woff'), url('../fonts/Gotham-Book.svg')format('svg');
font-weight: 400;
}

@font-face
{
font-family: 'Gotham';
src: url('../fonts/Gotham-Medium.eot');
src: url('../fonts/Gotham-Medium.eot?#iefix') format('embedded-opentype'), url('../fonts/Gotham-Medium.woff')format('woff'), url('../fonts/Gotham-Medium.otf')format('opentype'), url('../fonts/Gotham-Medium.svg')format('svg');
font-weight: 500;
}

@font-face
{
font-family: 'Gotham';
src: url('../fonts/Gotham-Bold.eot');
src: url('../fonts/Gotham-Bold.eot?#iefix') format('embedded-opentype'), url('../fonts/Gotham-Bold.otf')format('opentype');
font-weight: 700;
}

@font-face
{
font-family: 'Gotham';
src: url('../fonts/Gotham-Black.eot');
src: url('../fonts/Gotham-Black.eot?#iefix') format('embedded-opentype'), url('../fonts/Gotham-Black.woff')format('woff'), url('../fonts/Gotham-Black.otf')format('opentype');
font-weight: 900;
}

img.logo
{
width: 240px;
height: 66px;
}

@media (min-width: 1200px) {
.container{
    width:1028px;
    
}

.nav>li {
  margin-left: 0;
}

}

img.brand
{
width: 975px;

}

/* ------------------------------------ search bar start-------------------------------------------- */

.center-block {
    float: none;
    margin-left: auto;
    margin-right: auto;
}

.input-group .icon-addon .form-control {
    border-radius: 0;
}

.icon-addon {
    position: relative;
    color: #555;
    display: block;
}

.icon-addon:after,
.icon-addon:before {
    display: table;
    content: " ";
}

.icon-addon:after {
    clear: both;
}

.icon-addon.addon-md .glyphicon,
.icon-addon .glyphicon, 
.icon-addon.addon-md .fa,
.icon-addon .fa {
    position: absolute;
    z-index: 2;
    left: 10px;
    font-size: 14px;
    width: 20px;
    margin-left: -2.5px;
    text-align: center;
    padding: 10px 0;
    top: 1px
}

.icon-addon.addon-lg .form-control {
    line-height: 1.33;
    height: 46px;
    width:50%;
    border-color:black;
     border-radius: 0;
    font-size: 18px;
    padding: 10px 16px 10px 40px;
}

.icon-addon.addon-sm .form-control {
    height: 30px;
    padding: 5px 10px 5px 28px;
    font-size: 12px;
    line-height: 1.5;
}

.icon-addon.addon-lg .fa,
.icon-addon.addon-lg .glyphicon {
    font-size: 18px;
    margin-left: 0;
    left: 26%;
    top: 4px;
}

.icon-addon.addon-md .form-control,
.icon-addon .form-control {
    padding-left: 30px;
    float: center;
    font-weight: normal;
}

.icon-addon.addon-sm .fa,
.icon-addon.addon-sm .glyphicon {
    margin-left: 0;
    font-size: 12px;
    left: 5px;
    top: -1px
}

.icon-addon .form-control:focus + .glyphicon,
.icon-addon:hover .glyphicon,
.icon-addon .form-control:focus + .fa,
.icon-addon:hover .fa {
    color: #2580db;
}

/* ------------------------------------ search bar end-------------------------------------------- */


/* ------------------------------------ Post It Start-------------------------------------------- */

h3 {
font-family:  Gotham;
color:  #0088ce;
font-size:  28px; /* Approximation due to font substitution */
font-weight:  300;
text-align:  left;
}

h3.pl{
padding: 14px 0px 0px 14px;
}

.pl1{
padding: 14px 0px 0px 32px;
}

.gray-row{
background-color: #F2F2F2;
text-align: center;
}

.white-col-postit1{
background-color: white;
padding:5.5%;
margin: 3% 2% 3% 5%;
}

.white-col-postit2{
background-color: white;
padding:5%;
margin: 3% 2% 3% 5%;
}

/* ------------------------------------ Post It End-------------------------------------------- */

/* ------------------------------------ Colloborate and Discuss Start -------------------------------------------- */

.white-col-text
{
color: white;
margin: 4%;
}

.blueColor
{
background-color: #0088ce;
height: 312px;
}

.zeroPaddingLeft
{
padding-left: 0px;
}

.putItDown
{
position:absolute;
bottom:0;
margin-bottom: 10%;
margin: 4%;	
	
}

.pl2{
padding: 14px 0px 0px 32px;
margin: 0% 0% 3% -2%;
}

/* ------------------------------------ Colloborate and Discuss End -------------------------------------------- */

/* ---------------------------------------- Footer Start -------------------------------------------------------- */

.whiteColor
{
color: white;
}

/* ---------------------------------------- Footer End -------------------------------------------------------- */

/* ---------------------------------------- Button Start -------------------------------------------------------- */
.contactus-link-padding {
  position: absolute;
  bottom: 10%;
}
.white {
  color: #fefefe !important;
}
.pill {
  border-radius: 1000px;
}
.button-white {
  color: #fefefe !important;
  border-color: #fefefe;
}
.button {
  text-align: center;
  display: inline-block;
  height: 30px;
  border: 1px solid;
  transition: background-color 300ms ease-out;
  font-family: 'Gotham';
  font-weight: 500;
  text-decoration: none;
  line-height: 30px;
  padding: 0 1em;
  transition: color 300ms ease-out;
}
a {
  color: rgb(0, 136, 206);
  text-decoration: none;
  transition: color 300ms ease-out;
}

/* <a data-toggle="modal" role="button" class="button button-white pill white contactus-link-padding" type="button" href="#contactusmodel">CONTACT US</a> */


/* ---------------------------------------- Button End ----------------