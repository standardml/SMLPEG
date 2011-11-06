SMLPEG
======

SMLPEG is a Standard ML PEG generator, based largely on the self-hosting Javascript PEG generator
peg-bootstrap by Kragen Javier Sitaker (http://github.com/kragen/peg-bootstrap).

The syntax for PEGs is largely the same as peg-bootstrap.  Of interest might be the ever-present variable:

   val pos : int ref

Which will hold the current position in the file.

For an example PEG, look at the parser itself (smlpeg.peg).

There is little or no error handling at present.  This should be fixed eventually.

 -- Gian Perrone <gdpe at itu dot dk>, November 2011

