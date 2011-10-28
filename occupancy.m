function map = occupancy(serPort)

goalError = 0.2; % distance from goal to hit
angleError = 0.1; % radians, before we start going towards goal

if isSimulator(serPort)
    td = 0.1; % time delta to wait
    fs = 0.1; % forward speed
    as = 0.2; % angle speed (0, 0.2 m/s)    
    corrective = 1.0; %.5; % how much to fix the angle deltas by
else
    td = 0.01;
    fs = 0.1;
    as = 0.02;
    corrective = 1.5; 
end

pos = [0,0,0]; % [x,y,theta]

% drawing initialization
figure(1) % set the active figure handle to figure 1
clf; % clear figure 1
axis([0 10 -5 5]);
hold on; %Set figure 1 not to clear itself on each call to plot

start_time = tic;

while(toc(start_time) < 10.0)
    
    
    % wall_follower(serPort, [x,y,angle])
    % start_time = tic
    
end

