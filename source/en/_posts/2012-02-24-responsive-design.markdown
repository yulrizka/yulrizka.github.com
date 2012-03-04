---
layout: post
title: "Responsive Design"
date: 2012-02-24 01:47
language: en
comments: true
tags: [web]
description: Responsive website design with twitter bootstrap
keywords: responsive design, twitter bootstrap
---
I've been playing around with [twitter bootstrap][1]. It's like a css framework to help designer or developer create a nice and clean site. 
It's offer grid system, predefine layout, button, javascript, carousel etc. You can build website in just a few hours. Very nice for 
prototyping. 

I've been using it to build this blog since it was version 1. Recently i had a chance to upgrade it to version 2. 
The new version offer a lot of functionalities, one the feature that I play a lot is the responsive design.

Basically [Responsive Web Design][2] (RWD) means the ability of the web site to adapt to the user screen size. So the page should look different
in a way that it suited for specific screen. Like this website will look different if it's open with mobile phone, portrait mode on tablet,
landscape mode on tablet, net book or even in a large desktop. This actually achieved by using W3C CSS3 media query. It means that it uses 
different stylesheet for each of the screen size. More info on RWD in twitter bootstrap can be found [here][3]

You can test this functionality by resizing your browser window. Try to drag it slowly and watch the page banner slightly change.
here are the screen shoot of the design.

<ul class="thumbnails" style="text-align: center">
  <li class="span5">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836336/" title="Desktop View by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7188/6777836336_cfc30a387d.jpg" width="500" height="328" alt="Desktop View"></a>
      <div class="caption">Desktop View (1210px and up)</div>
    </div>
  </li>
  <li class="span5">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836342/" title="Tablet Landscape by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7177/6777836342_2bae8d18f9.jpg" width="500" height="403" alt="Tablet Landscape"></a>
      <div class="caption">Tablet Landscape (768px to 979px)</div>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836344/" title="Tablet View by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7068/6777836344_04a80d610b_m.jpg" width="240" height="237" alt="Tablet View"></a>
      <div class="caption">Tablet Portrait (480px to 768px)</div>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836350/" title="Tablet with menu by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7050/6777836350_3a8e661196_m.jpg" width="240" height="237" alt="Tablet with menu"></a>
      <div class="caption">Tablet Portrait with menu (480px to 768px)</div>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836354/" title="Mobile Phone by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7191/6777836354_aec27fd376_m.jpg" width="164" height="240" alt="Mobile Phone"></a>
      <div class="caption">Mobile Phone (480px and below)</div>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <a href="http://www.flickr.com/photos/77240053@N02/6777836358/" title="Mobile Phone with menu by yulrizka, on Flickr"><img src="http://farm8.staticflickr.com/7205/6777836358_d06448c5da_m.jpg" width="164" height="240" alt="Mobile Phone with menu"></a>
      <div class="caption">Mobile Phone with Menu(480px and below)</div>
    </div>
  </li>
</ul>

[1]: http://twitter.github.com/bootstrap/
[2]: http://en.wikipedia.org/wiki/Responsive_Web_Design
[3]: http://twitter.github.com/bootstrap/scaffolding.html#responsive