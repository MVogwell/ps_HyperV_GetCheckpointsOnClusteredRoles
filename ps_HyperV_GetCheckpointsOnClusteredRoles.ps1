###############################################
#
# ps_HyperV_GetCheckpointsOnClusteredRoles.ps1
# MVogwell - Oct 2018 - v1
#
# List all Hyper-V Checkpoints on VM Roles in a cluster
#
###############################################

Write-Output "`n`nPlease wait - gathering data...`n`n"

Try {
    # Get all nodes in the cluster
    $cn = Get-ClusterNode

    # For each node in the cluster retrieve the VMs hosted on the node
    ForEach ($n in $cn) {
        $vm = get-vm -ComputerName $n.name

        # For each VM on the node check for checkpoints
        foreach($m in $vm) {
            Get-VMSnapshot -VMName $m.name -ComputerName $n
        }
    }

    Write-Output "Task Completed"
}
Catch {
    Write-Output "... It has not been possible to return data on Hyper-V checkpoints. The error returned was: `n"
    Write-Output "$($Error[0].exception) `n"
}

# End