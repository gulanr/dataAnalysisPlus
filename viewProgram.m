function viewProgram(varargin)

f = varargin{1};

hData = guidata(f);

code = hData.matFile.Code;

prompt={'Enter Arduino Code:'};
defaultanswer = code;
name = 'AEV Data Analysis Plus';
numlines=[35 75];
code = inputdlg(prompt,name,numlines,defaultanswer);

hData.matFile.Code = code;

guidata(f,hData);
save([hData.matFile.fpath hData.matFile.fname],'code','-append');
end