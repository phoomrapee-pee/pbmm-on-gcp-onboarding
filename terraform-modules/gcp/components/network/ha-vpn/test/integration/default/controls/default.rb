region = input("region")
project_a = input("project_a")
project_b = input("project_b")
network_a = input('network_a')
network_b = input('network_b')
tunnel_1_name = input('tunnel_1_name')
tunnel_2_name = input('tunnel_2_name')
tunnel_3_name = input('tunnel_3_name')
tunnel_4_name = input('tunnel_4_name')

control "default" do
    title "default"

    describe google_compute_network(project: project_a, name: network_a) do
      it { should exist }
    end
    describe google_compute_network(project: project_b, name: network_b) do
      it { should exist }
    end

    describe google_compute_vpn_tunnel(project: project_a, region: region, name: tunnel_1_name) do
      it { should exist }
    end
    describe google_compute_vpn_tunnel(project: project_a, region: region, name: tunnel_2_name) do
      it { should exist }
    end
    describe google_compute_vpn_tunnel(project: project_b, region: region, name: tunnel_3_name) do
      it { should exist }
    end
    describe google_compute_vpn_tunnel(project: project_b, region: region, name: tunnel_4_name) do
      it { should exist }
    end
end
