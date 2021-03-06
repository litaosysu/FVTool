function faceGrad = gradientTermRadial2D(phi)
% this function calculates the gradient of a variable in x and y direction
% it checks for the availability of the ghost variables and use them, otherwise
% estimate them, assuming a zero gradient on the boundaries
% 
% SYNOPSIS:
%   faceGrad = gradientTermRadial2D(phi)
% 
% PARAMETERS:
%   
% 
% RETURNS:
%   
% 
% EXAMPLE:
% 
% SEE ALSO:
%     

%{
Copyright (c) 2012, 2013, Ali Akbar Eftekhari
All rights reserved.

Redistribution and use in source and binary forms, with or 
without modification, are permitted provided that the following 
conditions are met:

    *   Redistributions of source code must retain the above copyright notice, 
        this list of conditions and the following disclaimer.
    *   Redistributions in binary form must reproduce the above 
        copyright notice, this list of conditions and the following 
        disclaimer in the documentation and/or other materials provided 
        with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%}


% check the size of the variable and the mesh dimension
Nr = phi.domain.dims(1);
Ntheta = phi.domain.dims(2);
DR = repmat(phi.domain.cellsize.x, 1, Ntheta);
DTHETA = repmat(phi.domain.cellsize.y', Nr, 1);
dr = 0.5*(DR(1:end-1,:)+DR(2:end,:));
dtetta = 0.5*(DTHETA(:,1:end-1)+DTHETA(:,2:end));
rp = repmat(phi.domain.cellcenters.x, 1, Ntheta+1);

% in this case, ghost cells have values
xvalue = (phi.value(2:Nr+2,2:Ntheta+1)-phi.value(1:Nr+1,2:Ntheta+1))./dr;
yvalue = (phi.value(2:Nr+1,2:Ntheta+2)-phi.value(2:Nr+1,1:Ntheta+1))./(dtetta.*rp);
zvalue=[];
faceGrad=FaceVariable(phi.domain, xvalue, yvalue, zvalue);

