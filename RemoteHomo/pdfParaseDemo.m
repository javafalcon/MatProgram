% Purpose : Demonstrate extracting text from a PDF file using PDFBox Java library
% Usage   : Modify file paths
%           Enable cell mode and step through the code  
% Example : none (Oh, the FEX code metrics..)
% Author  : Dimitri Shvorob, dimitri.shvorob@gmail.com, 5/1/08  

%% 
clear java
javaaddpath('E:\360yunpan\JProgram\lib\PDFBox-0.7.3.jar')
javaaddpath('E:\360yunpan\JProgram\lib\FontBox-0.1.0.jar')
%%
pdfdoc = org.pdfbox.pdmodel.PDDocument;
reader = org.pdfbox.util.PDFTextStripper;

%%
pdfdoc = pdfdoc.load('ref\Supp-S1.pdf');
pdfdoc.isEncrypted

%% text, with planty of padding
pdfstr = reader.getText(pdfdoc)                  %#ok

%%
class(pdfstr)

%%
pdfstr = char(pdfstr)                            %#ok

%%
class(pdfstr)

%% text 'unpadded'
pdfstr = deblank(pdfstr)                         %#ok
pdfdoc.close()

fid = fopen('Supp-S1.txt','w+');
fprintf(fid,pdfstr);
fclose(fid);
%% will get an error here..
% pdfdoc = pdfdoc.load('M:\My Documents\MATLAB\PDF Exercise\Sample 2.pdf');
% pdfdoc.isEncrypted
% pdfstr = reader.getText(pdfdoc)                  %#ok

%% but press forward..
% javaaddpath('M:\My Documents\MATLAB\PDF Exercise\FontBox-0.1.0\lib\FontBox-0.1.0.jar')
% 
% pdfdoc = pdfdoc.load('M:\My Documents\MATLAB\PDF Exercise\Sample 2.pdf');
% pdfdoc.isEncrypted
% pdfstr = reader.getText(pdfdoc);
% pdfstr = deblank(char(pdfstr))                   %#ok

%% Has 'You did not close the PDF Document' came up already?
%% Do you know how to avoid it? Do let me know!