label = "product.Yield.Total"; 
setMinimumAnnual(label, 10000f);
setMaximumAnnual(label, 10000f);
setMinWeight(label, 1000f); // Adjust weight based on priority
setMaxWeight(label, 1000f);
control.getTarget(label).setLinear(true);
setActive(label, true, true, false);

// 2. WORKING FOREST REQUIREMENT: >= 80% from working forest
// This requires a feature label identifying the 'working_forest' land base
label = "proportion.harvest.working_forest";
setMinimumPeriodic(label, 0.80f); 
setMinWeight(label, 5000f);
setActive(label, true, true, false);

// 3. EVEN FLOW: +/- 25% between periods
// This uses the flow.even label logic
label = "flow.even.product.Yield.Total";
setMinimumPeriodic(label, -0.25f); // Allow 25% drop
setMaximumPeriodic(label, 0.25f);  // Allow 25% increase
setMinWeight(label, 1000000f);
setMaxWeight(label, 1000000f);
control.getTarget(label).setLinear(false);
setActive(label, true, true, true);

// 4. MATURE FOREST MAINTENANCE: 40% >= 20 years
// This usually targets a 'feature' or 'state'
label = "feature.Area.Age_GT_20"; 
// You'll need to calculate 40% of your total area as the min value
setMinimumPeriodic(label, 0.40f); 
setMinWeight(label, 2000f);
setActive(label, true, true, false);

////////////////////////////////////////////////////////
// Spatial & Operational Constraints
////////////////////////////////////////////////////////

// 5. MINIMUM HARVEST AGE: 70 years
// Usually set via a 'can_harvest' attribute or a specific constraint function
setMinimumHarvestAge(70); 

// 6. MAX OPENING SIZE: 15ha & GREEN-UP (5m height)
// These are typically spatial adjacency parameters
setMaxOpeningSize(15.0);
setGreenUpHeight(5.0); 

// 7. BUFFERS (Recreation Cores 300m, Corridors 200m)
// In most forest models, buffers are pre-calculated in the GIS 
// and the 'buffered' areas are flagged as 'non-harvestable'
setExcluded("feature.Rec_Core_Buffer_300m", true);
setExcluded("feature.Rec_Corridor_Buffer_200m", true);

////////////////////////////////////////////////////////
// Execution
////////////////////////////////////////////////////////

// Initial "Shake-down" run
gui.click("start");
control.waitForIterations(100000);
gui.clickAndWait("pause");

// Run until convergence @ 1%
analyze("scenarios/management_plan", 50000, 1);