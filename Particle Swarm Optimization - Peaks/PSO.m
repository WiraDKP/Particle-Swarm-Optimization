function [bestswarm, mincost] = PSO(problem, nvar, bound, param)
    
    func = problem;
    varsize = [1 nvar]; 
    
    itermax = param.itermax;
    npop = param.npop;
    w = param.w;
    wdamp = param.wdamp;
    c1 = param.c1;
    c2 = param.c2;

    xmin = bound.xmin;
    xmax = bound.xmax;
    vmin = bound.vmin;
    vmax = bound.vmax;
    
    globest.cost = inf;
    
    init.loc = [];
    init.vel = [];
    init.cost = [];
    init.best.loc = [];
    init.best.cost = [];

    swarm = repmat(init, npop, 1);

    for i = 1:npop
        swarm(i).loc = unifrnd(xmin, xmax, varsize);
        swarm(i).vel = zeros(varsize);
        swarm(i).cost = func(swarm(i).loc);
        swarm(i).best.loc = swarm(i).loc;
        swarm(i).best.cost = swarm(i).cost;   

        if swarm(i).best.cost < globest.cost
            globest = swarm(i).best;
        end
    end

    bestcost = zeros(itermax,1);
    tempX = zeros(itermax,npop);
    tempY = zeros(itermax,npop);
    
    for iter = 1:itermax
        [X,Y] = meshgrid(xmin:0.1:xmax, xmin:0.1:xmax);
        contour(X,Y,3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ... 
                - 1/3*exp(-(X+1).^2 - Y.^2), 25); hold on;
        scatter(0.2283,-1.6255,35,'ok','filled');
        title('MATLAB Peaks Function');
        for i = 1:npop
            swarm(i).vel =  min(max(w*swarm(i).vel + c1*rand(varsize).*(swarm(i).best.loc ...
                            - swarm(i).loc) + c2*rand(varsize).*(globest.loc - swarm(i).loc),vmax),vmin);
            swarm(i).loc = min(max(swarm(i).loc + swarm(i).vel, xmin),xmax);
            swarm(i).cost = func(swarm(i).loc);
            
            if swarm(i).cost < swarm(i).best.cost
                swarm(i).best.loc = swarm(i).loc;
                swarm(i).best.cost = swarm(i).cost;

                if swarm(i).best.cost < globest.cost
                    globest = swarm(i).best;
                end
            end
            tempX(iter,i) = swarm(i).loc(1);
            tempY(iter,i) = swarm(i).loc(2);
        end

        scatter(tempX(iter,:),tempY(iter,:),'xb');
        if(iter <=5)
            for i = 1:npop
                line(tempX(1:iter,i),tempY(1:iter,i));
            end            
        else
            for i = 1:npop
                line(tempX(iter-5:iter,i),tempY(iter-5:iter,i));
            end
        end

        frame(iter) = getframe(gcf); pause(0.0001);
        hold off;
        
        bestcost(iter) = globest.cost;
        disp(['Iteration ' num2str(iter) ' | Minimum cost = ' num2str(bestcost(iter))] );
        w = w*wdamp;
    end
    name = ['Peaks pop=' num2str(npop)];
    video = VideoWriter(name,'MPEG-4');
    video.FrameRate = 24;
    open(video)
    writeVideo(video,frame);
    close(video)
    
    clf
    for iter = 1:itermax
        plot(1:iter,bestcost(1:iter));
        axis([1 itermax -7 0 ]);
        title(['Minimum Value Plot | Population = ' num2str(npop) ' | MinVal = ' num2str(bestcost(iter))] );
        frame(iter) = getframe(gcf); pause(0.0001);        
    end
    
    name = ['Convergence pop=' num2str(npop)];
    video = VideoWriter(name,'MPEG-4');
    video.FrameRate = 24;
    open(video)
    writeVideo(video,frame);
    close(video)
    
    bestswarm = globest;
    mincost = bestcost;
end