function test_copt_qfi(; savefile=false)
    (; tspan, rho0, H0, dH, Hc, decay, ctrl, ctrl_bound) = generate_qubit_dynamics()

    dynamics = Lindblad(H0, dH, tspan, Hc, decay; ctrl=ctrl, dyn_method=:Expm)
    scheme = GeneralScheme(; probe=PlusState(), param=dynamics)

    obj = QFIM_obj()
    f0 = QFIM(scheme)[1]

    opt = ControlOpt(ctrl=ctrl, ctrl_bound=ctrl_bound, seed=1234)
    alg = autoGRAPE(Adam=true, max_episode=10, epsilon=0.01, beta1=0.90, beta2=0.99)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)

    f1 = QFIM(scheme)[1]
    @test isapprox(f1, f0; atol=1e-5) || f1 >= f0
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=true, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=false, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    dynamics = Lindblad(H0, dH, tspan, Hc, decay; ctrl=ctrl, dyn_method=:Ode)
    scheme = GeneralScheme(; probe=rho0, param=dynamics)

    alg = DE(p_num=3, max_episode=10)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = PSO(p_num=3, max_episode=[10, 10])
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")
end

function test_copt_qfim(; savefile=false)
    (; tspan, rho0, H0, dH, Hc, decay, ctrl, ctrl_bound) = generate_NV_dynamics()

    dynamics = Lindblad(H0, dH, tspan, Hc, decay; ctrl=ctrl, dyn_method=:Expm)
    scheme = GeneralScheme(; probe=rho0, param=dynamics)

    obj = QFIM_obj()
    f0 = tr(pinv(QFIM(scheme)))

    opt = ControlOpt(ctrl=ctrl, ctrl_bound=ctrl_bound, seed=1234)
    alg = autoGRAPE(Adam=true, max_episode=10, epsilon=0.01, beta1=0.90, beta2=0.99)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)

    f1 = tr(pinv(QFIM(scheme)))
    @test isapprox(f1, f0; atol=1e-5) || f1 <= f0

    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = PSO(p_num=3, max_episode=[10, 10])
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = DE(p_num=3, max_episode=10)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=true, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=false, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")
end

function test_copt_cfi(; savefile=false)
    (; tspan, rho0, H0, dH, Hc, decay, ctrl, ctrl_bound, M) = generate_qubit_dynamics()

    dynamics = Lindblad(H0, dH, tspan, Hc, decay; ctrl=ctrl, dyn_method=:Expm)
    scheme = GeneralScheme(; probe=rho0, param=dynamics, measurement=M)

    obj = CFIM_obj(M=M)
    f0 = CFIM(scheme)[1]

    opt = ControlOpt(ctrl=ctrl, ctrl_bound=ctrl_bound, seed=1234)
    alg =autoGRAPE(Adam=true, max_episode=10, epsilon=0.01, beta1=0.90, beta2=0.99)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)

    f1 = CFIM(scheme)[1]
    @test isapprox(f1, f0; atol=1e-5) || f1 >= f0
    
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = PSO(p_num=3, max_episode=[10, 10])
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = DE(p_num=3, max_episode=10)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=true, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=false, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")
end

function test_copt_cfim(; savefile=false)
    (; tspan, rho0, H0, dH, Hc, decay, ctrl, ctrl_bound, M) = generate_NV_dynamics()

    dynamics = Lindblad(H0, dH, tspan, Hc, decay; ctrl=ctrl, dyn_method=:Expm)
    scheme = GeneralScheme(; probe=rho0, param=dynamics, measurement=M)

    obj = CFIM_obj(M=M)
    f0 = tr(pinv(CFIM(scheme)))

    opt = ControlOpt(ctrl=ctrl, ctrl_bound=ctrl_bound, seed=1234)
    alg = autoGRAPE(Adam=true, max_episode=10, epsilon=0.01, beta1=0.90, beta2=0.99)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)

    f1 = tr(pinv(CFIM(scheme)))
    @test isapprox(f1, f0; atol=1e-5) || f1 <= f0

    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = PSO(p_num=3, max_episode=[10, 10])
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = DE(p_num=3, max_episode=10)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=true, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")

    alg = GRAPE(Adam=false, max_episode=3,)
    @suppress optimize!(scheme, opt; algorithm=alg, objective=obj, savefile=savefile)
    isfile("f.csv") && rm("f.csv")
    isfile("controls.dat") && rm("controls.dat")
    isfile("controls.csv") && rm("controls.csv")
end


function test_copt()
    @testset "Control Optimization QFIM" begin
        test_copt_qfi()
        test_copt_qfi(savefile=true)
        test_copt_qfim()
        test_copt_qfim(savefile=true)
    end

    @testset "Control Optimization CFIM" begin
        test_copt_cfi()
        test_copt_cfi(savefile=true)
        test_copt_cfim()
        test_copt_cfim(savefile=true)
    end
end

test_copt()
