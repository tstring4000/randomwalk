%Programmer: Tyler Stringer                             Date: 4-27-15
%Description: This program generates a random walk.

1; %The "1" ensures Octave doesn't think that this script is a function.

r = 1;  %Radius.

%Generate initial point.
plot(0,0)
hold on;

n = 1; 
nn = 1E3; %Number of iterations user wants.
x_old = 0;
y_old = 0;
j = 1; %Counter for cycling through color options.
rainbow = ['r', 'm', 'y', 'g', 'c', 'b', 'k'];
k = 1;
tslow = 1;  %Time in seconds for the pause time before plotting new line.
tfast = 0.02;   %Faster time for later on in the plotting.
tthreshold = 20;    %The iteration of the loop where we want to start speeding up the plotting.
h = axes;

while n <= nn && ishandle(h) %Do loop while n <= nn and if there is a figure present.
  theta = randi([0,359]); %Random integer degree between 0 and 359.
  x_comp = r*cosd(theta);
  y_comp = r*sind(theta);
  x = x_old + x_comp;
  y = y_old + y_comp;
    %Choose color of line
    choose_color = rainbow(j);
    if j < 7
      j = j+1;
    else
      j = 1;
    end
  line([x_old x],[y_old y],'Color',choose_color) %For a 3D line:   line([.3 .7],[.4 .9],[1 1],'Marker','.','LineStyle','-')
  plot(x,y)
  figure = plot(x,y);
  set(h,'XTick',zeros(1,0),'XTickLabel',{},'YTick',zeros(1,0),...
    'YTickLabel',{});   %Remove labels on axes so it doesn't get muddied over time with new labels on each iteration of loop.
  hold on;
  n = n+1;
  x_old = x; %New x value becomes the old.
  y_old = y; %Same for y.
  sim(n) = theta; %Array of simulation's theta values.
  if n < tthreshold
    pause(tslow); %Wait half a second (or however long the user wants). Comment out if you only want to see the final result (takes longer for larger nn). 
  else
    pause(tfast); %Plot the lines faster now ... we don't want to wait all day.
  end
  %filename = sprintf('output/fig%0.4d.png',k);
  %saveas(figure,filename); %Uncomment if you want to save the figures (later you can make an animated gif, etc.).
  %k++;
end
