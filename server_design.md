# serving static files

One issue I'm running into as I learn graphql is how to serve static
content like images.  I want the same auth system, and I want to
discover paths to images using the graph system, but I can't serve
gobs of images via postgres/postgraphql.

Most howtos talk about how to set up the graph side, but they don't
talk about how to serve the usual REST stuff like images.

# jwt and express

So perhaps the best way is to wrap postgraphql in express, and use
express jwt.  Or any other language.  JWT then protects the route to
the static images.  If jsw is not on, then no images are served.  If
jwt is on, then you can see images.

Would also be cool if graphql could be used to limit what images are
seen based on the user.  query the graph to get the list of images
that are visible to the user account that has logged in.

# Use case

My use case is an image server for Grace to remove her need for stupid
drop box.  My plan is to let her log in to the web server, and see
images.  Then she can expose what images she wants to public
download.  So that's back to grace notes; how ironic.

# simplest case

Just a log in.  Grace logs in, all images are visible.  Log out, no
images are visible.

# next case

Log in turns on graphql image information.  Can download raw, can
upload edited JPG when image is RAW.  Can add notes to image.  Can
generate a static image page.

# Version 0.1 Server code

Super simple express or phoenix app or something to offer two paths.
One to postgraphql for login, auth; another to the image service when
logged in.
