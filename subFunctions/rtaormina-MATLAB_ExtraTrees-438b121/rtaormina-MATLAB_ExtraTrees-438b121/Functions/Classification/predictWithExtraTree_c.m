function output = predictWithExtraTree_c(TREE,S)
%
% This function performs a recursive search within the Extra-Tree
% and returns the class estimate for each pattern in S.
%
% Inputs : 
% TREE      = the Extra-Tree
% split     = dataset of attribute patterns
% 
% Outputs : 
% output    = output produced by the Extra-Tree for each pattern
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@gmail.com 
%
%
% Please refer to README.txt for bibliographical references on Extra-Trees!
%
% This file is part of MATLAB_ExtraTrees
%
%     MATLAB_ExtraTrees is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     Foobar is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_ExtraTrees_classification.  If not, see <http://www.gnu.org/licenses/>.



% get dataset length and preallocate memory for the output
n  = size(S,1);
output = zeros(n,1);

% return the prediction if the node is a leaf 
if TREE.isLeaf == 1
    output = repmat(TREE.leafValue,[n,1]);
    return
  
else
    
% ... otherwhise continue the search recursively
if TREE.splitAttIsCategorical == 0
    splitIxes = S(:,TREE.splitAtt)==TREE.splitVal;
else 
    splitIxes = S(:,TREE.splitAtt)>TREE.splitVal;
end
    
    
    output(splitIxes) = predictWithExtraTree_c(...
        TREE.child1,S(splitIxes,:));
    
    output(~splitIxes) = predictWithExtraTree_c(...
        TREE.child2,S(~splitIxes,:));
    end
end