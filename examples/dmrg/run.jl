using ITensors, Printf, Profile, ProfileView

N = 100
sites = spinones(N)
H = Heisenberg(sites)
psi0 = randomMPS(sites)
sw = Sweeps(5)
cutoff!(sw,1E-10)

#G.S. energy for N=10,S=1/2 Heisenberg is -4.258035206805 

maxdim!(sw,10,20,100,100,200)
energy,psi = @time dmrg(H,psi0,sw,maxiter=3)
@printf "Final energy = %.12f\n" energy

Profile.clear()  # in case we have any previous profiling data
@profile dmrg(H,psi0,sw,maxiter=3)
ProfileView.view()

