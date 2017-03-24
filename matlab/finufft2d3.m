function [f ier] = finufft2d3(x,y,c,isign,eps,s,t,o)
% FINUFFT2D3
%
% [f ier] = finufft2d3(x,y,c,isign,eps,s,t)
% [f ier] = finufft2d3(x,y,c,isign,eps,s,t,opts)
%
%              nj
%     f[k]  =  SUM   c[j] exp(+-i (s[k] x[j] + t[k] y[j])),  for k = 1, ..., nk
%              j=1
%   Inputs:
%     x,y    location of NU sources in R^2, each length nj.
%     c      size-nj double complex array of source strengths
%     s,t    frequency locations of NU targets in R^2.
%     isign  if >=0, uses + sign in exponential, otherwise - sign.
%     eps    precision requested (>1e-16)
%     opts.debug: 0 (silent), 1 (timing breakdown), 2 (debug info).
%     opts.maxnalloc - largest number of array elements for internal alloc
%                      (0 has no effect)
%     opts.nthreads sets requested number of threads (else automatic)
%   Outputs:
%     f     size-nk double complex Fourier transform values at target
%            frequencies s,t
%     returned value - 0 if success, else:
%                      1 : eps too small
%		       2 : size of arrays to malloc exceed opts.maxnalloc

if nargin<8, o=[]; end
debug=0; if isfield(o,'debug'), debug = o.debug; end
maxnalloc=0; if isfield(o,'maxnalloc'), maxnalloc = o.maxnalloc; end
nthreads=0; if isfield(o,'nthreads'), nthreads = o.nthreads; end
nj=numel(x);
nk=numel(s);
if numel(y)~=nj, error('y must have the same number of elements as x'); end
if numel(c)~=nj, error('c must have the same number of elements as x'); end
if numel(t)~=nk, error('t must have the same number of elements as s'); end

mex_id_ = 'o int = finufft2d3m(i double, i double[], i double[], i dcomplex[x], i int, i double, i double, i double[], i double[], o dcomplex[x], i int, i double, i int)';
[ier, f] = finufft(mex_id_, nj, x, y, c, isign, eps, nk, s, t, debug, maxnalloc, nthreads, nj, nk);

% ------------------------------------------------------------------------
