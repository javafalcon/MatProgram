function fisherdraw(w1,w2,w,y0)
o1=(w*(w'*w1'))';
for i=1:length(o1)
    h=line([o1(i,1),w1(i,1)],[o1(i,2),w1(i,2)]);
    set(h,'Color','r','LineStyle','--');
end
hold on;
o2 = (w*(w'*w2'))';
for i = 1:length(o2)
    h=line([o2(i,1),w2(i,1)],[o2(i,2),w2(i,2)]);
    set(h,'Color','b','LineStyle','--');
end
th=(w*y0)';
plot(th(1),th(2),'rx','LineWidth',2,'MarkerSize',8);
% axis hight
% axis equal
h=gca;
XLim=get(h,'XLim');
YLim = get(h,'YLim');
l=(w*(w'*[XLim(1),YLim(1)]'))';
r=(w*(w'*[XLim(2),YLim(2)]'))';
h=line([l(1),r(1)],[l(2),r(2)]);
set(h,'color','k');