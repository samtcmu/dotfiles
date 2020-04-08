new-session -s finance -n asset-allocation -c ~/private/finance/asset-allocation 'vim assets.csv'
split-window -h -c ~/private/finance/asset-allocation

new-window -n balance-sheet -c ~/private/finance/balance-sheet 'vim balance-sheet.csv'
split-window -h -c ~/private/finance/balance-sheet

new-window -n ledger -c ~/private/finance/ledger 'vim ledger.txt'
split-window -h -c ~/private/finance/ledger
