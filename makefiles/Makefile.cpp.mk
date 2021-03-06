#### DYNAMIC link and libs ####

# List libraries by module.
DYNAMIC_BASE_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)util.$(DYNAMIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)base.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_LP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)linear_solver.$(DYNAMIC_LIB_SUFFIX) \
	$(LIB_DIR)/$(LIBPREFIX)bop.$(DYNAMIC_LIB_SUFFIX) \
	$(LIB_DIR)/$(LIBPREFIX)glop.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_ALGORITHMS_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)algorithms.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_SPLIT_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)split.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_CP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)constraint_solver.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_GRAPH_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)graph.$(DYNAMIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)shortestpaths.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_ROUTING_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)routing.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_FLATZINC_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)fz.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_DIMACS_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)dimacs.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_FAP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)fap.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_SAT_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)sat.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_BOP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)bop.$(DYNAMIC_LIB_SUFFIX)

DYNAMIC_ORTOOLS_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX)

# Lib dependencies.
DYNAMIC_BASE_DEPS = $(DYNAMIC_BASE_LIBS)

DYNAMIC_GRAPH_DEPS = $(DYNAMIC_GRAPH_LIBS) \
	$(DYNAMIC_BASE_DEPS)

DYNAMIC_LP_DEPS = \
	$(GEN_DIR)/linear_solver/linear_solver2.pb.h \
	$(DYNAMIC_LP_LIBS) \
	$(DYNAMIC_SAT_LIBS) \
	$(DYNAMIC_SPLIT_LIBS) \
	$(DYNAMIC_BASE_DEPS)

DYNAMIC_ALGORITHMS_DEPS = $(DYNAMIC_ALGORITHMS_LIBS)\
	 $(DYNAMIC_LP_DEPS)

DYNAMIC_SAT_DEPS = $(DYNAMIC_SAT_LIBS) \
	$(DYNAMIC_SPLIT_LIBS) \
        $(DYNAMIC_ALGORITHMS_DEPS)

DYNAMIC_BOP_DEPS = $(DYNAMIC_BOP_LIBS) \
	$(DYNAMIC_SAT_DEPS)

DYNAMIC_CP_DEPS = $(DYNAMIC_CP_LIBS) \
	$(DYNAMIC_BASE_DEPS) \
	$(DYNAMIC_LP_DEPS) \
	$(DYNAMIC_SAT_DEPS)

DYNAMIC_ROUTING_DEPS = $(DYNAMIC_ROUTING_LIBS) \
	$(DYNAMIC_BASE_DEPS) \
	$(DYNAMIC_CP_DEPS) \
	$(DYNAMIC_GRAPH_DEPS)

DYNAMIC_FLATZINC_DEPS = $(DYNAMIC_FLATZINC_LIBS) \
        $(DYNAMIC_CP_DEPS)

DYNAMIC_DIMACS_DEPS = $(DYNAMIC_DIMACS_LIBS) \
        $(DYNAMIC_BASE_DEPS) \
        $(DYNAMIC_GRAPH_DEPS) \
        $(DYNAMIC_ALGORITHMS_DEPS) \
        $(DYNAMIC_LP_DEPS)

DYNAMIC_FAP_DEPS = $(DYNAMIC_FAP_LIBS) \
        $(DYNAMIC_BASE_DEPS) \
        $(DYNAMIC_CP_DEPS) \
        $(DYNAMIC_LP_DEPS)

DYNAMIC_ORTOOLS_DEPS = \
        $(DYNAMIC_ORTOOLS_LIBS)

# Create link commands.
DYNAMIC_BASE_LNK = \
        $(DYNAMIC_PRE_LIB)util$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)base$(DYNAMIC_POST_LIB)

DYNAMIC_GRAPH_LNK = \
        $(DYNAMIC_PRE_LIB)graph$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)shortestpaths$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_BASE_LNK)

DYNAMIC_LP_LNK = \
        $(DYNAMIC_PRE_LIB)linear_solver$(DYNAMIC_POST_LIB) \
	$(DYNAMIC_PRE_LIB)bop$(DYNAMIC_POST_LIB) \
	$(DYNAMIC_PRE_LIB)glop$(DYNAMIC_POST_LIB) \
	$(DYNAMIC_PRE_LIB)sat$(DYNAMIC_POST_LIB) \
	$(DYNAMIC_PRE_LIB)split$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_BASE_LNK) \
        $(DYNAMIC_LD_LP_DEPS)  # Third party linear solvers.

DYNAMIC_ALGORITHMS_LNK = \
        $(DYNAMIC_PRE_LIB)algorithms$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_LP_LNK)

DYNAMIC_SAT_LNK = \
        $(DYNAMIC_PRE_LIB)sat$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)split$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_ALGORITHMS_LNK)

DYNAMIC_CP_LNK = \
        $(DYNAMIC_PRE_LIB)constraint_solver$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_SAT_LNK)

DYNAMIC_ROUTING_LNK = \
        $(DYNAMIC_PRE_LIB)routing$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)graph$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)shortestpaths$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_CP_LNK)

DYNAMIC_FLATZINC_LNK = \
        $(DYNAMIC_PRE_LIB)fz$(DYNAMIC_POST_LIB)\
        $(DYNAMIC_CP_LNK)

DYNAMIC_DIMACS_LNK = \
        $(DYNAMIC_PRE_LIB)graph$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)shortestpaths$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_PRE_LIB)dimacs$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_ALGORITHMS_LNK)

DYNAMIC_FAP_LNK = \
        $(DYNAMIC_PRE_LIB)fap$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_CP_LNK)

# TODO(lperron): update to include FZ, FAP, DIMACS, ...
DYNAMIC_ALL_LNK = \
  $(DYNAMIC_PRE_LIB)algorithms$(DYNAMIC_POST_LIB) \
        $(DYNAMIC_ROUTING_LNK)

DYNAMIC_ORTOOLS_LNK = \
        $(DYNAMIC_PRE_LIB)ortools$(DYNAMIC_POST_LIB)

#### STATIC link and libs ####

# List libraries by module.
STATIC_BASE_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)util.$(STATIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)base.$(STATIC_LIB_SUFFIX)

STATIC_LP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)linear_solver.$(STATIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)bop.$(STATIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)glop.$(STATIC_LIB_SUFFIX)

STATIC_ALGORITHMS_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)algorithms.$(STATIC_LIB_SUFFIX)

STATIC_SPLIT_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)split.$(STATIC_LIB_SUFFIX)

STATIC_CP_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)constraint_solver.$(STATIC_LIB_SUFFIX)

STATIC_GRAPH_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)graph.$(STATIC_LIB_SUFFIX) \
        $(LIB_DIR)/$(LIBPREFIX)shortestpaths.$(STATIC_LIB_SUFFIX)

STATIC_ROUTING_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)routing.$(STATIC_LIB_SUFFIX)

STATIC_FLATZINC_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)fz.$(STATIC_LIB_SUFFIX)

STATIC_SAT_LIBS = \
        $(LIB_DIR)/$(LIBPREFIX)sat.$(STATIC_LIB_SUFFIX)

STATIC_BOP_LIBS = \
	$(LIB_DIR)/$(LIBPREFIX)bop.$(STATIC_LIB_SUFFIX)

# Lib dependencies.
STATIC_BASE_DEPS = $(STATIC_BASE_LIBS)

STATIC_GRAPH_DEPS = $(STATIC_GRAPH_LIBS) \
	$(STATIC_BASE_DEPS)

STATIC_BOP_DEPS = $(STATIC_BOP_LIBS) \
	$(STATIC_SAT_LIBS) \
	$(STATIC_ALGORITHMS_LIBS)

STATIC_LP_DEPS = $(STATIC_LP_LIBS) \
	$(STATIC_BOP_DEPS) \
	$(STATIC_SPLIT_LIBS) \
	$(STATIC_BASE_DEPS)

STATIC_ALGORITHMS_DEPS = $(STATIC_ALGORITHMS_LIBS) \
	$(STATIC_BASE_DEPS) \
	$(STATIC_LP_DEPS)

STATIC_SAT_DEPS = $(STATIC_SAT_LIBS) \
	$(STATIC_ALGORITHMS_DEPS)

STATIC_CP_DEPS = $(STATIC_CP_LIBS) \
	$(STATIC_BASE_DEPS) \
	$(STATIC_LP_DEPS) \
	$(STATIC_SAT_DEPS)

STATIC_ROUTING_DEPS = $(STATIC_ROUTING_LIBS) \
	$(STATIC_BASE_DEPS) \
	$(STATIC_CP_DEPS) \
	$(STATIC_GRAPH_DEPS)

STATIC_FLATZINC_DEPS = $(STATIC_FLATZINC_LIBS) \
	$(STATIC_BASE_DEPS) \
	$(STATIC_CP_DEPS)

STATIC_ALL_DEPS = \
	$(STATIC_BASE_LIBS) \
	$(STATIC_GRAPH_LIBS) \
	$(STATIC_LP_LIBS) \
	$(STATIC_ALGORITHMS_LIBS) \
	$(STATIC_SPLIT_LIBS) \
	$(STATIC_SAT_LIBS) \
	$(STATIC_CP_LIBS) \
	$(STATIC_ROUTING_LIBS)

# Create link commands.
STATIC_BASE_LNK = \
        $(STATIC_PRE_LIB)util$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)base$(STATIC_POST_LIB)

STATIC_GRAPH_LNK = \
        $(STATIC_PRE_LIB)graph$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)shortestpaths$(STATIC_POST_LIB) \
        $(STATIC_BASE_LNK)

STATIC_BOP_LNK = \
        $(STATIC_PRE_LIB)bop$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)sat$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)split$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)algorithms$(STATIC_POST_LIB)

STATIC_LP_LNK = \
        $(STATIC_PRE_LIB)linear_solver$(STATIC_POST_LIB) \
        $(STATIC_BOP_LNK) \
        $(STATIC_PRE_LIB)glop$(STATIC_POST_LIB) \
        $(STATIC_BASE_LNK) \
        $(STATIC_LD_LP_DEPS)  # Third party linear solvers.

STATIC_ALGORITHMS_LNK = \
        $(STATIC_PRE_LIB)algorithms$(STATIC_POST_LIB) \
        $(STATIC_LP_LNK)

STATIC_SAT_LNK = \
        $(STATIC_PRE_LIB)sat$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)split$(STATIC_POST_LIB) \
        $(STATIC_ALGORITHMS_LNK)

STATIC_CP_LNK = \
        $(STATIC_PRE_LIB)constraint_solver$(STATIC_POST_LIB) \
        $(STATIC_SAT_LNK)

STATIC_ROUTING_LNK = \
        $(STATIC_PRE_LIB)routing$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)graph$(STATIC_POST_LIB) \
        $(STATIC_PRE_LIB)shortestpaths$(STATIC_POST_LIB) \
        $(STATIC_CP_LNK)

STATIC_FLATZINC_LNK = \
        $(STATIC_PRE_LIB)fz$(STATIC_POST_LIB)\
        $(STATIC_CP_LNK)

# TODO(lperron): update to include FZ.
STATIC_ALL_LNK = \
        $(STATIC_PRE_LIB)algorithms$(STATIC_POST_LIB) \
        $(STATIC_ROUTING_LNK)

# Binaries

CPBINARIES = \
	$(BIN_DIR)/costas_array$E \
	$(BIN_DIR)/cryptarithm$E \
	$(BIN_DIR)/cvrptw$E \
	$(BIN_DIR)/cvrptw_with_refueling$E \
	$(BIN_DIR)/cvrptw_with_resources$E \
	$(BIN_DIR)/cvrptw_with_stop_times_and_resources$E \
	$(BIN_DIR)/dobble_ls$E \
	$(BIN_DIR)/flow_api$E \
	$(BIN_DIR)/golomb$E \
	$(BIN_DIR)/jobshop$E \
	$(BIN_DIR)/jobshop_ls$E \
	$(BIN_DIR)/linear_assignment_api$E \
	$(BIN_DIR)/ls_api$E \
	$(BIN_DIR)/magic_square$E \
	$(BIN_DIR)/model_util$E \
	$(BIN_DIR)/multidim_knapsack$E \
	$(BIN_DIR)/network_routing$E \
	$(BIN_DIR)/nqueens$E \
	$(BIN_DIR)/pdptw$E \
	$(BIN_DIR)/dimacs_assignment$E \
	$(BIN_DIR)/sports_scheduling$E \
	$(BIN_DIR)/tsp$E

LPBINARIES = \
	$(BIN_DIR)/integer_programming$E \
	$(BIN_DIR)/linear_programming$E \
	$(BIN_DIR)/linear_solver_protocol_buffers$E \
	$(BIN_DIR)/strawberry_fields_with_column_generation$E \
	$(BIN_DIR)/mps_driver$E \
	$(BIN_DIR)/solve$E


# Special dimacs example.

# Makefile targets.

# Main target
cc: cplibs cpexe algorithmslibs graphlibs lplibs lpexe

# Clean target

clean_cc:
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)base.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)util.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)constraint_solver.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)linear_solver.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)bop.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)glop.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)graph.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)routing.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)algorithms.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)dimacs.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)fz.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)fz2.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)sat.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)shortestpaths.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)base.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)util.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)constraint_solver.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)linear_solver.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)bop.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)glop.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)graph.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)routing.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)algorithms.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)shortestpaths.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)fz.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)fz2.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(LIB_DIR)$S$(LIBPREFIX)sat.$(STATIC_LIB_SUFFIX)
	-$(DEL) $(OBJ_DIR)$S*.$O
	-$(DEL) $(OBJ_DIR)$Salgorithms$S*.$O
	-$(DEL) $(OBJ_DIR)$Sbase$S*.$O
	-$(DEL) $(OBJ_DIR)$Sflatzinc$S*.$O
	-$(DEL) $(OBJ_DIR)$Sbop$S*.$O
	-$(DEL) $(OBJ_DIR)$Sglop$S*.$O
	-$(DEL) $(OBJ_DIR)$Slp_data$S*.$O
	-$(DEL) $(OBJ_DIR)$Sgraph$S*.$O
	-$(DEL) $(OBJ_DIR)$Ssat$S*.$O
	-$(DEL) $(OBJ_DIR)$Sconstraint_solver$S*.$O
	-$(DEL) $(OBJ_DIR)$Slinear_solver$S*.$O
	-$(DEL) $(OBJ_DIR)$Sutil$S*.$O
	-$(DEL) $(BIN_DIR)$Sfz$E
	-$(DEL) $(BIN_DIR)$Sfz2$E
	-$(DEL) $(BIN_DIR)$Sparser_main$E
	-$(DEL) $(BIN_DIR)$Ssat_runner$E
	-$(DEL) $(CPBINARIES)
	-$(DEL) $(LPBINARIES)
	-$(DEL) $(GEN_DIR)$Sconstraint_solver$S*.pb.*
	-$(DEL) $(GEN_DIR)$Slinear_solver$S*.pb.*
	-$(DEL) $(GEN_DIR)$Sbop$S*.pb.*
	-$(DEL) $(GEN_DIR)$Sglop$S*.pb.*
	-$(DEL) $(GEN_DIR)$Sflatzinc$Sflatzinc.tab.*
	-$(DEL) $(GEN_DIR)$Sflatzinc$Sflatzinc.yy.*
	-$(DEL) $(GEN_DIR)$Ssat$S*.pb.*
	-$(DEL) $(BIN_DIR)$S*.exp
	-$(DEL) $(BIN_DIR)$S*.lib
	-$(DELREC) $(OR_ROOT)src$Sgen$Sflatzinc2
	-$(DELREC) $(OR_ROOT)objs$Sflatzinc2

clean_compat:
	-$(DELREC) $(OR_ROOT)constraint_solver
	-$(DELREC) $(OR_ROOT)linear_solver
	-$(DELREC) $(OR_ROOT)algorithms
	-$(DELREC) $(OR_ROOT)graph
	-$(DELREC) $(OR_ROOT)gen


# Individual targets.
algorithmslibs: $(DYNAMIC_ALGORITHMS_DEPS) $(STATIC_ALGORITHMS_DEPS) $(DYNAMIC_SPLIT_DEPS) $(STATIC_SPLIT_DEPS)

cpexe: $(CPBINARIES)

cplibs: $(DYNAMIC_CP_DEPS) $(STATIC_CP_DEPS)

lpexe: $(LPBINARIES)

lplibs: $(DYNAMIC_LP_DEPS) $(STATIC_LP_DEPS)

graphlibs: $(DYNAMIC_GRAPH_DEPS) $(STATIC_GRAPH_DEPS)

dimacslibs: $(DYNAMIC_DIMACS_LIBS)

faplibs: $(DYNAMIC_FAP_LIBS)

# Constraint Solver Lib.

CONSTRAINT_SOLVER_LIB_OBJS = \
	$(OBJ_DIR)/constraint_solver/alldiff_cst.$O\
	$(OBJ_DIR)/constraint_solver/assignment.$O\
	$(OBJ_DIR)/constraint_solver/assignment.pb.$O\
	$(OBJ_DIR)/constraint_solver/ac4r_table.$O\
	$(OBJ_DIR)/constraint_solver/ac4_mdd_reset_table.$O\
	$(OBJ_DIR)/constraint_solver/collect_variables.$O\
	$(OBJ_DIR)/constraint_solver/constraint_solver.$O\
	$(OBJ_DIR)/constraint_solver/constraints.$O\
	$(OBJ_DIR)/constraint_solver/count_cst.$O\
	$(OBJ_DIR)/constraint_solver/default_search.$O\
	$(OBJ_DIR)/constraint_solver/demon_profiler.$O\
	$(OBJ_DIR)/constraint_solver/demon_profiler.pb.$O\
	$(OBJ_DIR)/constraint_solver/dependency_graph.$O\
	$(OBJ_DIR)/constraint_solver/deviation.$O\
	$(OBJ_DIR)/constraint_solver/diffn.$O\
	$(OBJ_DIR)/constraint_solver/element.$O\
	$(OBJ_DIR)/constraint_solver/expr_array.$O\
	$(OBJ_DIR)/constraint_solver/expr_cst.$O\
	$(OBJ_DIR)/constraint_solver/expressions.$O\
	$(OBJ_DIR)/constraint_solver/gcc.$O\
	$(OBJ_DIR)/constraint_solver/hybrid.$O\
	$(OBJ_DIR)/constraint_solver/graph_constraints.$O\
	$(OBJ_DIR)/constraint_solver/interval.$O\
	$(OBJ_DIR)/constraint_solver/io.$O\
	$(OBJ_DIR)/constraint_solver/local_search.$O\
	$(OBJ_DIR)/constraint_solver/model.pb.$O\
	$(OBJ_DIR)/constraint_solver/model_cache.$O\
	$(OBJ_DIR)/constraint_solver/nogoods.$O\
	$(OBJ_DIR)/constraint_solver/pack.$O\
	$(OBJ_DIR)/constraint_solver/range_cst.$O\
	$(OBJ_DIR)/constraint_solver/resource.$O\
	$(OBJ_DIR)/constraint_solver/sat_constraint.$O\
	$(OBJ_DIR)/constraint_solver/sched_constraints.$O\
	$(OBJ_DIR)/constraint_solver/sched_expr.$O\
	$(OBJ_DIR)/constraint_solver/sched_search.$O\
	$(OBJ_DIR)/constraint_solver/search.$O\
	$(OBJ_DIR)/constraint_solver/search_limit.pb.$O\
	$(OBJ_DIR)/constraint_solver/table.$O\
	$(OBJ_DIR)/constraint_solver/timetabling.$O\
	$(OBJ_DIR)/constraint_solver/trace.$O\
	$(OBJ_DIR)/constraint_solver/tree_monitor.$O\
	$(OBJ_DIR)/constraint_solver/utilities.$O \
	$(OBJ_DIR)/constraint_solver/visitor.$O

$(OBJ_DIR)/constraint_solver/alldiff_cst.$O:$(SRC_DIR)/constraint_solver/alldiff_cst.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/alldiff_cst.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Salldiff_cst.$O

$(OBJ_DIR)/constraint_solver/assignment.$O:$(SRC_DIR)/constraint_solver/assignment.cc $(GEN_DIR)/constraint_solver/assignment.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/assignment.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sassignment.$O

$(OBJ_DIR)/constraint_solver/assignment.pb.$O:$(GEN_DIR)/constraint_solver/assignment.pb.cc
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/constraint_solver/assignment.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sassignment.pb.$O

$(OBJ_DIR)/constraint_solver/ac4r_table.$O:$(SRC_DIR)/constraint_solver/ac4r_table.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/ac4r_table.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sac4r_table.$O

$(OBJ_DIR)/constraint_solver/ac4_mdd_reset_table.$O:$(SRC_DIR)/constraint_solver/ac4_mdd_reset_table.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/ac4_mdd_reset_table.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sac4_mdd_reset_table.$O

$(GEN_DIR)/constraint_solver/assignment.pb.cc:$(SRC_DIR)/constraint_solver/assignment.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/constraint_solver/assignment.proto

$(GEN_DIR)/constraint_solver/assignment.pb.h:$(GEN_DIR)/constraint_solver/assignment.pb.cc

$(OBJ_DIR)/constraint_solver/collect_variables.$O:$(SRC_DIR)/constraint_solver/collect_variables.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/collect_variables.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Scollect_variables.$O

$(OBJ_DIR)/constraint_solver/constraint_solver.$O:$(SRC_DIR)/constraint_solver/constraint_solver.cc $(GEN_DIR)/constraint_solver/model.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/constraint_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sconstraint_solver.$O

$(OBJ_DIR)/constraint_solver/constraints.$O:$(SRC_DIR)/constraint_solver/constraints.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/constraints.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sconstraints.$O

$(OBJ_DIR)/constraint_solver/count_cst.$O:$(SRC_DIR)/constraint_solver/count_cst.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/count_cst.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Scount_cst.$O

$(OBJ_DIR)/constraint_solver/default_search.$O:$(SRC_DIR)/constraint_solver/default_search.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/default_search.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdefault_search.$O

$(OBJ_DIR)/constraint_solver/demon_profiler.$O:$(SRC_DIR)/constraint_solver/demon_profiler.cc $(GEN_DIR)/constraint_solver/demon_profiler.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/demon_profiler.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdemon_profiler.$O

$(OBJ_DIR)/constraint_solver/demon_profiler.pb.$O:$(GEN_DIR)/constraint_solver/demon_profiler.pb.cc
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/constraint_solver/demon_profiler.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdemon_profiler.pb.$O

$(GEN_DIR)/constraint_solver/demon_profiler.pb.cc:$(SRC_DIR)/constraint_solver/demon_profiler.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/constraint_solver/demon_profiler.proto

$(GEN_DIR)/constraint_solver/demon_profiler.pb.h:$(GEN_DIR)/constraint_solver/demon_profiler.pb.cc

$(OBJ_DIR)/constraint_solver/dependency_graph.$O:$(SRC_DIR)/constraint_solver/dependency_graph.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/dependency_graph.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdependency_graph.$O

$(OBJ_DIR)/constraint_solver/deviation.$O:$(SRC_DIR)/constraint_solver/deviation.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/deviation.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdeviation.$O

$(OBJ_DIR)/constraint_solver/diffn.$O:$(SRC_DIR)/constraint_solver/diffn.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/diffn.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sdiffn.$O

$(OBJ_DIR)/constraint_solver/element.$O:$(SRC_DIR)/constraint_solver/element.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/element.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Selement.$O

$(OBJ_DIR)/constraint_solver/expr_array.$O:$(SRC_DIR)/constraint_solver/expr_array.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/expr_array.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sexpr_array.$O

$(OBJ_DIR)/constraint_solver/expr_cst.$O:$(SRC_DIR)/constraint_solver/expr_cst.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/expr_cst.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sexpr_cst.$O

$(OBJ_DIR)/constraint_solver/expressions.$O:$(SRC_DIR)/constraint_solver/expressions.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/expressions.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sexpressions.$O

$(OBJ_DIR)/constraint_solver/gcc.$O:$(SRC_DIR)/constraint_solver/gcc.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/gcc.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sgcc.$O

$(OBJ_DIR)/constraint_solver/graph_constraints.$O:$(SRC_DIR)/constraint_solver/graph_constraints.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/graph_constraints.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sgraph_constraints.$O

$(OBJ_DIR)/constraint_solver/hybrid.$O:$(SRC_DIR)/constraint_solver/hybrid.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/hybrid.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Shybrid.$O

$(OBJ_DIR)/constraint_solver/interval.$O:$(SRC_DIR)/constraint_solver/interval.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/interval.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sinterval.$O

$(OBJ_DIR)/constraint_solver/io.$O:$(SRC_DIR)/constraint_solver/io.cc $(GEN_DIR)/constraint_solver/model.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/io.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sio.$O

$(OBJ_DIR)/constraint_solver/local_search.$O:$(SRC_DIR)/constraint_solver/local_search.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/local_search.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Slocal_search.$O

$(OBJ_DIR)/constraint_solver/model.pb.$O:$(GEN_DIR)/constraint_solver/model.pb.cc
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/constraint_solver/model.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Smodel.pb.$O

$(OBJ_DIR)/constraint_solver/model_cache.$O:$(SRC_DIR)/constraint_solver/model_cache.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/model_cache.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Smodel_cache.$O

$(GEN_DIR)/constraint_solver/model.pb.cc:$(SRC_DIR)/constraint_solver/model.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/constraint_solver/model.proto

$(GEN_DIR)/constraint_solver/model.pb.h:$(GEN_DIR)/constraint_solver/model.pb.cc $(GEN_DIR)/constraint_solver/search_limit.pb.h

$(OBJ_DIR)/constraint_solver/nogoods.$O:$(SRC_DIR)/constraint_solver/nogoods.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/nogoods.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Snogoods.$O

$(OBJ_DIR)/constraint_solver/pack.$O:$(SRC_DIR)/constraint_solver/pack.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/pack.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Spack.$O

$(OBJ_DIR)/constraint_solver/range_cst.$O:$(SRC_DIR)/constraint_solver/range_cst.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/range_cst.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Srange_cst.$O

$(OBJ_DIR)/constraint_solver/resource.$O:$(SRC_DIR)/constraint_solver/resource.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/resource.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sresource.$O

$(OBJ_DIR)/constraint_solver/sat_constraint.$O:$(SRC_DIR)/constraint_solver/sat_constraint.cc $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/sat_constraint.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssat_constraint.$O

$(OBJ_DIR)/constraint_solver/sched_constraints.$O:$(SRC_DIR)/constraint_solver/sched_constraints.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/sched_constraints.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssched_constraints.$O

$(OBJ_DIR)/constraint_solver/sched_expr.$O:$(SRC_DIR)/constraint_solver/sched_expr.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/sched_expr.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssched_expr.$O

$(OBJ_DIR)/constraint_solver/sched_search.$O:$(SRC_DIR)/constraint_solver/sched_search.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/sched_search.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssched_search.$O

$(OBJ_DIR)/constraint_solver/search.$O:$(SRC_DIR)/constraint_solver/search.cc $(GEN_DIR)/constraint_solver/search_limit.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/search.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssearch.$O

$(OBJ_DIR)/constraint_solver/search_limit.pb.$O:$(GEN_DIR)/constraint_solver/search_limit.pb.cc
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/constraint_solver/search_limit.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssearch_limit.pb.$O

$(GEN_DIR)/constraint_solver/search_limit.pb.cc:$(SRC_DIR)/constraint_solver/search_limit.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/constraint_solver/search_limit.proto

$(GEN_DIR)/constraint_solver/search_limit.pb.h:$(GEN_DIR)/constraint_solver/search_limit.pb.cc

$(OBJ_DIR)/constraint_solver/softgcc.$O:$(SRC_DIR)/constraint_solver/softgcc.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/softgcc.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Ssoftgcc.$O

$(OBJ_DIR)/constraint_solver/table.$O:$(SRC_DIR)/constraint_solver/table.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/table.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Stable.$O

$(OBJ_DIR)/constraint_solver/timetabling.$O:$(SRC_DIR)/constraint_solver/timetabling.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/timetabling.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Stimetabling.$O

$(OBJ_DIR)/constraint_solver/trace.$O:$(SRC_DIR)/constraint_solver/trace.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/trace.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Strace.$O

$(OBJ_DIR)/constraint_solver/tree_monitor.$O:$(SRC_DIR)/constraint_solver/tree_monitor.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/tree_monitor.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Stree_monitor.$O

$(OBJ_DIR)/constraint_solver/utilities.$O:$(SRC_DIR)/constraint_solver/utilities.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/utilities.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Sutilities.$O

$(OBJ_DIR)/constraint_solver/visitor.$O:$(SRC_DIR)/constraint_solver/visitor.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/visitor.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Svisitor.$O

$(LIB_DIR)/$(LIBPREFIX)constraint_solver.$(DYNAMIC_LIB_SUFFIX): $(CONSTRAINT_SOLVER_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)constraint_solver.$(DYNAMIC_LIB_SUFFIX) $(CONSTRAINT_SOLVER_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)constraint_solver.$(STATIC_LIB_SUFFIX): $(CONSTRAINT_SOLVER_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)constraint_solver.$(STATIC_LIB_SUFFIX) $(CONSTRAINT_SOLVER_LIB_OBJS)
endif

# Linear Solver Library

LINEAR_SOLVER_LIB_OBJS = \
	$(OBJ_DIR)/linear_solver/bop_interface.$O \
	$(OBJ_DIR)/linear_solver/glop_interface.$O \
	$(OBJ_DIR)/linear_solver/cbc_interface.$O \
	$(OBJ_DIR)/linear_solver/cplex_interface.$O \
	$(OBJ_DIR)/linear_solver/clp_interface.$O \
	$(OBJ_DIR)/linear_solver/glpk_interface.$O \
	$(OBJ_DIR)/linear_solver/gurobi_interface.$O \
	$(OBJ_DIR)/linear_solver/linear_solver.$O \
	$(OBJ_DIR)/linear_solver/linear_solver2.pb.$O \
	$(OBJ_DIR)/linear_solver/model_exporter.$O \
	$(OBJ_DIR)/linear_solver/scip_interface.$O \
	$(OBJ_DIR)/linear_solver/sulum_interface.$O


$(OBJ_DIR)/linear_solver/cbc_interface.$O:$(SRC_DIR)/linear_solver/cbc_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/linear_solver/cbc_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Scbc_interface.$O

$(OBJ_DIR)/linear_solver/clp_interface.$O:$(SRC_DIR)/linear_solver/clp_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/linear_solver/clp_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sclp_interface.$O

$(OBJ_DIR)/linear_solver/bop_interface.$O:$(SRC_DIR)/linear_solver/bop_interface.cc $(GEN_DIR)/bop/bop_parameters.pb.h $(GEN_DIR)/sat/sat_parameters.pb.h $(GEN_DIR)/sat/boolean_problem.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Sbop_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sbop_interface.$O

$(OBJ_DIR)/linear_solver/cplex_interface.$O:$(SRC_DIR)/linear_solver/cplex_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/linear_solver/cplex_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Scplex_interface.$O

$(OBJ_DIR)/linear_solver/glop_interface.$O:$(SRC_DIR)/linear_solver/glop_interface.cc $(GEN_DIR)/glop/parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Sglop_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sglop_interface.$O

$(OBJ_DIR)/linear_solver/glpk_interface.$O:$(SRC_DIR)/linear_solver/glpk_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Sglpk_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sglpk_interface.$O

$(OBJ_DIR)/linear_solver/gurobi_interface.$O:$(SRC_DIR)/linear_solver/gurobi_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Sgurobi_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sgurobi_interface.$O

$(OBJ_DIR)/linear_solver/linear_solver.$O:$(SRC_DIR)/linear_solver/linear_solver.cc $(GEN_DIR)/linear_solver/linear_solver2.pb.h $(GEN_DIR)/glop/parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Slinear_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Slinear_solver.$O

$(OBJ_DIR)/linear_solver/linear_solver2.pb.$O:$(GEN_DIR)/linear_solver/linear_solver2.pb.cc
	$(CCC) $(CFLAGS) -c $(GEN_DIR)$Slinear_solver$Slinear_solver2.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Slinear_solver2.pb.$O

$(GEN_DIR)/linear_solver/linear_solver2.pb.cc:$(SRC_DIR)/linear_solver/linear_solver2.proto
	$(PROTOBUF_DIR)$Sbin$Sprotoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)$Slinear_solver$Slinear_solver2.proto

$(GEN_DIR)/linear_solver/linear_solver2.pb.h:$(GEN_DIR)/linear_solver/linear_solver2.pb.cc

$(OBJ_DIR)/linear_solver/model_exporter.$O:$(SRC_DIR)/linear_solver/model_exporter.cc $(GEN_DIR)/linear_solver/linear_solver2.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Smodel_exporter.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Smodel_exporter.$O

$(OBJ_DIR)/linear_solver/scip_interface.$O:$(SRC_DIR)/linear_solver/scip_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Sscip_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Sscip_interface.$O

$(OBJ_DIR)/linear_solver/sulum_interface.$O:$(SRC_DIR)/linear_solver/sulum_interface.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Slinear_solver$Ssulum_interface.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver$Ssulum_interface.$O

$(LIB_DIR)/$(LIBPREFIX)linear_solver.$(DYNAMIC_LIB_SUFFIX): $(LINEAR_SOLVER_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)linear_solver.$(DYNAMIC_LIB_SUFFIX) $(LINEAR_SOLVER_LIB_OBJS) $(STATIC_SCIP_LNK)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)linear_solver.$(STATIC_LIB_SUFFIX): $(LINEAR_SOLVER_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)linear_solver.$(STATIC_LIB_SUFFIX) $(LINEAR_SOLVER_LIB_OBJS)
endif

# Util library.

UTIL_LIB_OBJS=\
	$(OBJ_DIR)/util/bitset.$O \
	$(OBJ_DIR)/util/cached_log.$O \
	$(OBJ_DIR)/util/fp_utils.$O \
	$(OBJ_DIR)/util/graph_export.$O \
	$(OBJ_DIR)/util/piecewise_linear_function.$O \
	$(OBJ_DIR)/util/proto_tools.$O \
	$(OBJ_DIR)/util/rational_approximation.$O \
	$(OBJ_DIR)/util/stats.$O \
	$(OBJ_DIR)/util/time_limit.$O \
	$(OBJ_DIR)/util/xml_helper.$O

$(OBJ_DIR)/util/bitset.$O:$(SRC_DIR)/util/bitset.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/bitset.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sbitset.$O

$(OBJ_DIR)/util/cached_log.$O:$(SRC_DIR)/util/cached_log.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/cached_log.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Scached_log.$O

$(OBJ_DIR)/util/fp_utils.$O:$(SRC_DIR)/util/fp_utils.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/fp_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sfp_utils.$O

$(OBJ_DIR)/util/graph_export.$O:$(SRC_DIR)/util/graph_export.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/graph_export.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sgraph_export.$O

$(OBJ_DIR)/util/piecewise_linear_function.$O:$(SRC_DIR)/util/piecewise_linear_function.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/piecewise_linear_function.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Spiecewise_linear_function.$O

$(OBJ_DIR)/util/proto_tools.$O:$(SRC_DIR)/util/proto_tools.cc $(GEN_DIR)/linear_solver/linear_solver2.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sutil$Sproto_tools.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sproto_tools.$O

$(OBJ_DIR)/util/rational_approximation.$O:$(SRC_DIR)/util/rational_approximation.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/rational_approximation.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Srational_approximation.$O

$(OBJ_DIR)/util/stats.$O:$(SRC_DIR)/util/stats.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/stats.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sstats.$O

$(OBJ_DIR)/util/time_limit.$O:$(SRC_DIR)/util/time_limit.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/time_limit.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Stime_limit.$O

$(OBJ_DIR)/util/xml_helper.$O:$(SRC_DIR)/util/xml_helper.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/util/xml_helper.cc $(OBJ_OUT)$(OBJ_DIR)$Sutil$Sxml_helper.$O

$(LIB_DIR)/$(LIBPREFIX)util.$(DYNAMIC_LIB_SUFFIX): $(UTIL_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)util.$(DYNAMIC_LIB_SUFFIX) $(UTIL_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)util.$(STATIC_LIB_SUFFIX): $(UTIL_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)util.$(STATIC_LIB_SUFFIX) $(UTIL_LIB_OBJS)
endif

# Graph library.

GRAPH_LIB_OBJS=\
	$(OBJ_DIR)/graph/simple_assignment.$O \
	$(OBJ_DIR)/graph/linear_assignment.$O \
	$(OBJ_DIR)/graph/cliques.$O \
	$(OBJ_DIR)/graph/connectivity.$O \
	$(OBJ_DIR)/graph/flow_problem.pb.$O \
	$(OBJ_DIR)/graph/max_flow.$O \
	$(OBJ_DIR)/graph/min_cost_flow.$O

$(OBJ_DIR)/graph/linear_assignment.$O:$(SRC_DIR)/graph/linear_assignment.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/linear_assignment.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Slinear_assignment.$O

$(OBJ_DIR)/graph/simple_assignment.$O:$(SRC_DIR)/graph/assignment.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/assignment.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Ssimple_assignment.$O

$(OBJ_DIR)/graph/cliques.$O:$(SRC_DIR)/graph/cliques.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/cliques.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Scliques.$O

$(OBJ_DIR)/graph/connectivity.$O:$(SRC_DIR)/graph/connectivity.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/connectivity.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Sconnectivity.$O

$(GEN_DIR)/graph/flow_problem.pb.cc:$(SRC_DIR)/graph/flow_problem.proto
	 $(PROTOBUF_DIR)$Sbin$Sprotoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)$Sgraph$Sflow_problem.proto

$(GEN_DIR)/graph/flow_problem.pb.h:$(GEN_DIR)/graph/flow_problem.pb.cc

$(OBJ_DIR)/graph/flow_problem.pb.$O:$(GEN_DIR)/graph/flow_problem.pb.cc
	 $(CCC) $(CFLAGS) -c $(GEN_DIR)$Sgraph$Sflow_problem.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Sflow_problem.pb.$O

$(OBJ_DIR)/graph/max_flow.$O:$(SRC_DIR)/graph/max_flow.cc $(SRC_DIR)/util/stats.h $(GEN_DIR)/graph/flow_problem.pb.h
	 $(PROTOBUF_DIR)$Sbin$Sprotoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)$Sgraph$Sflow_problem.proto
	 $(PROTOBUF_DIR)$Sbin$Sprotoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)$Sgraph$Sflow_problem.proto
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/max_flow.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Smax_flow.$O

$(OBJ_DIR)/graph/min_cost_flow.$O:$(SRC_DIR)/graph/min_cost_flow.cc $(GEN_DIR)/graph/flow_problem.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/min_cost_flow.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Smin_cost_flow.$O

$(LIB_DIR)/$(LIBPREFIX)graph.$(DYNAMIC_LIB_SUFFIX): $(GRAPH_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)graph.$(DYNAMIC_LIB_SUFFIX) $(GRAPH_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)graph.$(STATIC_LIB_SUFFIX): $(GRAPH_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)graph.$(STATIC_LIB_SUFFIX) $(GRAPH_LIB_OBJS)
endif

# Shortestpaths library.

SHORTESTPATHS_LIB_OBJS=\
	$(OBJ_DIR)/graph/bellman_ford.$O \
	$(OBJ_DIR)/graph/dijkstra.$O \
	$(OBJ_DIR)/graph/shortestpaths.$O

$(OBJ_DIR)/graph/bellman_ford.$O:$(SRC_DIR)/graph/bellman_ford.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/bellman_ford.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Sbellman_ford.$O

$(OBJ_DIR)/graph/dijkstra.$O:$(SRC_DIR)/graph/dijkstra.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/dijkstra.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Sdijkstra.$O

$(OBJ_DIR)/graph/shortestpaths.$O:$(SRC_DIR)/graph/shortestpaths.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/graph/shortestpaths.cc $(OBJ_OUT)$(OBJ_DIR)$Sgraph$Sshortestpaths.$O

$(LIB_DIR)/$(LIBPREFIX)shortestpaths.$(DYNAMIC_LIB_SUFFIX): $(SHORTESTPATHS_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)shortestpaths.$(DYNAMIC_LIB_SUFFIX) $(SHORTESTPATHS_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)shortestpaths.$(STATIC_LIB_SUFFIX): $(SHORTESTPATHS_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)shortestpaths.$(STATIC_LIB_SUFFIX) $(SHORTESTPATHS_LIB_OBJS)
endif

# Routing library.

ROUTING_LIB_OBJS=\
	$(OBJ_DIR)/constraint_solver/routing.$O \
	$(OBJ_DIR)/constraint_solver/routing_search.$O

$(OBJ_DIR)/constraint_solver/routing.$O:$(SRC_DIR)/constraint_solver/routing.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/routing.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Srouting.$O

$(OBJ_DIR)/constraint_solver/routing_search.$O:$(SRC_DIR)/constraint_solver/routing_search.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/constraint_solver/routing_search.cc $(OBJ_OUT)$(OBJ_DIR)$Sconstraint_solver$Srouting_search.$O

$(LIB_DIR)/$(LIBPREFIX)routing.$(DYNAMIC_LIB_SUFFIX): $(ROUTING_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)routing.$(DYNAMIC_LIB_SUFFIX) $(ROUTING_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)routing.$(STATIC_LIB_SUFFIX): $(ROUTING_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)routing.$(STATIC_LIB_SUFFIX) $(ROUTING_LIB_OBJS)
endif

# Algorithms library.

SPLIT_LIB_OBJS=\
	$(OBJ_DIR)/algorithms/dynamic_partition.$O \
	$(OBJ_DIR)/algorithms/dynamic_permutation.$O \
	$(OBJ_DIR)/algorithms/sparse_permutation.$O \
	$(OBJ_DIR)/algorithms/find_graph_symmetries.$O

ALGORITHMS_LIB_OBJS=\
	$(OBJ_DIR)/algorithms/hungarian.$O \
	$(OBJ_DIR)/algorithms/knapsack_solver.$O

$(OBJ_DIR)/algorithms/hungarian.$O:$(SRC_DIR)/algorithms/hungarian.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/hungarian.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Shungarian.$O

$(OBJ_DIR)/algorithms/knapsack_solver.$O:$(SRC_DIR)/algorithms/knapsack_solver.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/knapsack_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Sknapsack_solver.$O

$(OBJ_DIR)/algorithms/dynamic_partition.$O:$(SRC_DIR)/algorithms/dynamic_partition.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/dynamic_partition.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Sdynamic_partition.$O

$(OBJ_DIR)/algorithms/dynamic_permutation.$O:$(SRC_DIR)/algorithms/dynamic_permutation.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/dynamic_permutation.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Sdynamic_permutation.$O

$(OBJ_DIR)/algorithms/sparse_permutation.$O:$(SRC_DIR)/algorithms/sparse_permutation.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/sparse_permutation.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Ssparse_permutation.$O

$(OBJ_DIR)/algorithms/find_graph_symmetries.$O:$(SRC_DIR)/algorithms/find_graph_symmetries.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/algorithms/find_graph_symmetries.cc $(OBJ_OUT)$(OBJ_DIR)$Salgorithms$Sfind_graph_symmetries.$O

$(LIB_DIR)/$(LIBPREFIX)algorithms.$(DYNAMIC_LIB_SUFFIX): $(ALGORITHMS_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)algorithms.$(DYNAMIC_LIB_SUFFIX) $(ALGORITHMS_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)algorithms.$(STATIC_LIB_SUFFIX): $(ALGORITHMS_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)algorithms.$(STATIC_LIB_SUFFIX) $(ALGORITHMS_LIB_OBJS)
endif

$(LIB_DIR)/$(LIBPREFIX)split.$(DYNAMIC_LIB_SUFFIX): $(SPLIT_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)split.$(DYNAMIC_LIB_SUFFIX) $(SPLIT_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)split.$(STATIC_LIB_SUFFIX): $(SPLIT_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)split.$(STATIC_LIB_SUFFIX) $(SPLIT_LIB_OBJS)
endif

# Base library.

BASE_LIB_OBJS=\
	$(OBJ_DIR)/base/bitmap.$O\
	$(OBJ_DIR)/base/callback.$O\
	$(OBJ_DIR)/base/file.$O\
	$(OBJ_DIR)/base/filelinereader.$O\
	$(OBJ_DIR)/base/join.$O\
	$(OBJ_DIR)/base/logging.$O\
	$(OBJ_DIR)/base/mutex.$O\
	$(OBJ_DIR)/base/numbers.$O\
	$(OBJ_DIR)/base/random.$O\
	$(OBJ_DIR)/base/recordio.$O\
	$(OBJ_DIR)/base/split.$O\
	$(OBJ_DIR)/base/stringpiece.$O\
	$(OBJ_DIR)/base/stringprintf.$O\
	$(OBJ_DIR)/base/sysinfo.$O\
	$(OBJ_DIR)/base/threadpool.$O\
	$(OBJ_DIR)/base/timer.$O \
	$(OBJ_DIR)/base/time_support.$O

$(OBJ_DIR)/base/bitmap.$O:$(SRC_DIR)/base/bitmap.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/bitmap.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sbitmap.$O
$(OBJ_DIR)/base/callback.$O:$(SRC_DIR)/base/callback.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/callback.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Scallback.$O
$(OBJ_DIR)/base/file.$O:$(SRC_DIR)/base/file.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/file.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sfile.$O
$(OBJ_DIR)/base/filelinereader.$O:$(SRC_DIR)/base/filelinereader.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/filelinereader.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sfilelinereader.$O
$(OBJ_DIR)/base/logging.$O:$(SRC_DIR)/base/logging.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/logging.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Slogging.$O
$(OBJ_DIR)/base/mutex.$O:$(SRC_DIR)/base/mutex.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/mutex.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Smutex.$O
$(OBJ_DIR)/base/numbers.$O:$(SRC_DIR)/base/numbers.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/numbers.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Snumbers.$O
$(OBJ_DIR)/base/join.$O:$(SRC_DIR)/base/join.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/join.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sjoin.$O
$(OBJ_DIR)/base/random.$O:$(SRC_DIR)/base/random.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/random.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Srandom.$O
$(OBJ_DIR)/base/recordio.$O:$(SRC_DIR)/base/recordio.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/recordio.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Srecordio.$O
$(OBJ_DIR)/base/threadpool.$O:$(SRC_DIR)/base/threadpool.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/threadpool.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sthreadpool.$O
$(OBJ_DIR)/base/split.$O:$(SRC_DIR)/base/split.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/split.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Ssplit.$O
$(OBJ_DIR)/base/stringpiece.$O:$(SRC_DIR)/base/stringpiece.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/stringpiece.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sstringpiece.$O
$(OBJ_DIR)/base/stringprintf.$O:$(SRC_DIR)/base/stringprintf.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/stringprintf.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Sstringprintf.$O
$(OBJ_DIR)/base/sysinfo.$O:$(SRC_DIR)/base/sysinfo.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/sysinfo.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Ssysinfo.$O
$(OBJ_DIR)/base/timer.$O:$(SRC_DIR)/base/timer.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/timer.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Stimer.$O
$(OBJ_DIR)/base/time_support.$O:$(SRC_DIR)/base/time_support.cc
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/base/time_support.cc $(OBJ_OUT)$(OBJ_DIR)$Sbase$Stime_support.$O

$(LIB_DIR)/$(LIBPREFIX)base.$(DYNAMIC_LIB_SUFFIX): $(BASE_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)base.$(DYNAMIC_LIB_SUFFIX) $(BASE_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)base.$(STATIC_LIB_SUFFIX): $(BASE_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)base.$(STATIC_LIB_SUFFIX) $(BASE_LIB_OBJS)
endif

# Glop library.

LP_DATA_OBJS= \
  $(OBJ_DIR)/lp_data/lp_data.$O \
  $(OBJ_DIR)/lp_data/lp_decomposer.$O \
  $(OBJ_DIR)/lp_data/lp_print_utils.$O \
  $(OBJ_DIR)/lp_data/lp_types.$O \
  $(OBJ_DIR)/lp_data/lp_utils.$O \
  $(OBJ_DIR)/lp_data/matrix_scaler.$O \
  $(OBJ_DIR)/lp_data/matrix_utils.$O \
  $(OBJ_DIR)/lp_data/mps_reader.$O \
  $(OBJ_DIR)/lp_data/sparse.$O \
  $(OBJ_DIR)/lp_data/sparse_column.$O \

$(OBJ_DIR)/lp_data/lp_data.$O:$(SRC_DIR)/lp_data/lp_data.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Slp_data.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Slp_data.$O

$(OBJ_DIR)/lp_data/lp_decomposer.$O:$(SRC_DIR)/lp_data/lp_decomposer.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Slp_decomposer.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Slp_decomposer.$O

$(OBJ_DIR)/lp_data/lp_print_utils.$O:$(SRC_DIR)/lp_data/lp_print_utils.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Slp_print_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Slp_print_utils.$O

$(OBJ_DIR)/lp_data/lp_types.$O:$(SRC_DIR)/lp_data/lp_types.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Slp_types.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Slp_types.$O

$(OBJ_DIR)/lp_data/lp_utils.$O:$(SRC_DIR)/lp_data/lp_utils.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Slp_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Slp_utils.$O

$(OBJ_DIR)/lp_data/matrix_scaler.$O:$(SRC_DIR)/lp_data/matrix_scaler.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Smatrix_scaler.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Smatrix_scaler.$O

$(OBJ_DIR)/lp_data/matrix_utils.$O:$(SRC_DIR)/lp_data/matrix_utils.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Smatrix_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Smatrix_utils.$O

$(OBJ_DIR)/lp_data/mps_reader.$O:$(SRC_DIR)/lp_data/mps_reader.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Smps_reader.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Smps_reader.$O

$(OBJ_DIR)/lp_data/mps_to_png.$O:$(SRC_DIR)/lp_data/mps_to_png.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Smps_to_png.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Smps_to_png.$O

$(OBJ_DIR)/lp_data/png_dump.$O:$(SRC_DIR)/lp_data/png_dump.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Spng_dump.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Spng_dump.$O

$(OBJ_DIR)/lp_data/sparse.$O:$(SRC_DIR)/lp_data/sparse.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Ssparse.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Ssparse.$O

$(OBJ_DIR)/lp_data/sparse_column.$O:$(SRC_DIR)/lp_data/sparse_column.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Slp_data$Ssparse_column.cc $(OBJ_OUT)$(OBJ_DIR)$Slp_data$Ssparse_column.$O

GLOP_LIB_OBJS= $(LP_DATA_OBJS) \
  $(OBJ_DIR)/glop/basis_representation.$O \
  $(OBJ_DIR)/glop/dual_edge_norms.$O \
  $(OBJ_DIR)/glop/entering_variable.$O \
  $(OBJ_DIR)/glop/initial_basis.$O \
  $(OBJ_DIR)/glop/lp_solver.$O \
  $(OBJ_DIR)/glop/lu_factorization.$O \
  $(OBJ_DIR)/glop/markowitz.$O \
  $(OBJ_DIR)/glop/parameters.pb.$O \
  $(OBJ_DIR)/glop/preprocessor.$O \
  $(OBJ_DIR)/glop/primal_edge_norms.$O \
  $(OBJ_DIR)/glop/proto_utils.$O \
  $(OBJ_DIR)/glop/reduced_costs.$O \
  $(OBJ_DIR)/glop/revised_simplex.$O \
  $(OBJ_DIR)/glop/status.$O \
  $(OBJ_DIR)/glop/update_row.$O \
  $(OBJ_DIR)/glop/variables_info.$O \
  $(OBJ_DIR)/glop/variable_values.$O

$(GEN_DIR)/glop/parameters.pb.cc:$(SRC_DIR)/glop/parameters.proto
	 $(PROTOBUF_DIR)$Sbin$Sprotoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)$Sglop$Sparameters.proto

$(GEN_DIR)/glop/parameters.pb.h:$(GEN_DIR)/glop/parameters.pb.cc

$(OBJ_DIR)/glop/parameters.pb.$O:$(GEN_DIR)/glop/parameters.pb.cc
	 $(CCC) $(CFLAGS) -c $(GEN_DIR)$Sglop$Sparameters.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sparameters.pb.$O

$(OBJ_DIR)/glop/basis_representation.$O:$(SRC_DIR)/glop/basis_representation.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sbasis_representation.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sbasis_representation.$O

$(OBJ_DIR)/glop/dual_edge_norms.$O:$(SRC_DIR)/glop/dual_edge_norms.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sdual_edge_norms.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sdual_edge_norms.$O

$(OBJ_DIR)/glop/entering_variable.$O:$(SRC_DIR)/glop/entering_variable.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sentering_variable.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sentering_variable.$O

$(OBJ_DIR)/glop/initial_basis.$O:$(SRC_DIR)/glop/initial_basis.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sinitial_basis.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sinitial_basis.$O

$(OBJ_DIR)/glop/lp_solver.$O:$(SRC_DIR)/glop/lp_solver.cc  $(GEN_DIR)/linear_solver/linear_solver2.pb.h
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Slp_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Slp_solver.$O

$(OBJ_DIR)/glop/lu_factorization.$O:$(SRC_DIR)/glop/lu_factorization.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Slu_factorization.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Slu_factorization.$O

$(OBJ_DIR)/glop/markowitz.$O:$(SRC_DIR)/glop/markowitz.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Smarkowitz.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Smarkowitz.$O

$(OBJ_DIR)/glop/preprocessor.$O:$(SRC_DIR)/glop/preprocessor.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Spreprocessor.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Spreprocessor.$O

$(OBJ_DIR)/glop/primal_edge_norms.$O:$(SRC_DIR)/glop/primal_edge_norms.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sprimal_edge_norms.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sprimal_edge_norms.$O

$(OBJ_DIR)/glop/proto_driver.$O:$(SRC_DIR)/glop/proto_driver.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sproto_driver.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sproto_driver.$O

$(OBJ_DIR)/glop/proto_txt_to_bin.$O:$(SRC_DIR)/glop/proto_txt_to_bin.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sproto_txt_to_bin.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sproto_txt_to_bin.$O

$(OBJ_DIR)/glop/proto_utils.$O:$(SRC_DIR)/glop/proto_utils.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sproto_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sproto_utils.$O

$(OBJ_DIR)/glop/reduced_costs.$O:$(SRC_DIR)/glop/reduced_costs.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sreduced_costs.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sreduced_costs.$O

$(OBJ_DIR)/glop/revised_simplex.$O:$(SRC_DIR)/glop/revised_simplex.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Srevised_simplex.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Srevised_simplex.$O

$(OBJ_DIR)/glop/status.$O:$(SRC_DIR)/glop/status.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Sstatus.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Sstatus.$O

$(OBJ_DIR)/glop/update_row.$O:$(SRC_DIR)/glop/update_row.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Supdate_row.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Supdate_row.$O

$(OBJ_DIR)/glop/variables_info.$O:$(SRC_DIR)/glop/variables_info.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Svariables_info.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Svariables_info.$O

$(OBJ_DIR)/glop/variable_values.$O:$(SRC_DIR)/glop/variable_values.cc
	 $(CCC) $(CFLAGS) -c $(SRC_DIR)$Sglop$Svariable_values.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Svariable_values.$O

$(LIB_DIR)/$(LIBPREFIX)glop.$(DYNAMIC_LIB_SUFFIX): $(GLOP_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)glop.$(DYNAMIC_LIB_SUFFIX) $(GLOP_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)glop.$(STATIC_LIB_SUFFIX): $(GLOP_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)glop.$(STATIC_LIB_SUFFIX) $(GLOP_LIB_OBJS)
endif

$(OBJ_DIR)/glop/mps_driver.$O:$(EX_DIR)/cpp/mps_driver.cc $(GEN_DIR)/glop/parameters.pb.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Smps_driver.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Smps_driver.$O

$(BIN_DIR)/mps_driver$E: $(OBJ_DIR)/glop/mps_driver.$O $(STATIC_LP_DEPS)
	$(CCC) $(CFLAGS) $(OBJ_DIR)$Sglop$Smps_driver.$O $(STATIC_LP_LNK) $(STATIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Smps_driver$E

$(OBJ_DIR)/glop/solve.$O:$(EX_DIR)/cpp/solve.cc $(GEN_DIR)/glop/parameters.pb.h $(GEN_DIR)/linear_solver/linear_solver2.pb.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Ssolve.cc $(OBJ_OUT)$(OBJ_DIR)$Sglop$Ssolve.$O

$(BIN_DIR)/solve$E: $(OBJ_DIR)/glop/solve.$O $(STATIC_LP_DEPS)
	$(CCC) $(CFLAGS) $(OBJ_DIR)$Sglop$Ssolve.$O $(STATIC_LP_LNK) $(STATIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Ssolve$E


# DIMACS challenge problem format library

DIMACS_LIB_OBJS=\
	$(OBJ_DIR)/parse_dimacs_assignment.$O

$(OBJ_DIR)/parse_dimacs_assignment.$O:$(EX_DIR)/cpp/parse_dimacs_assignment.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/parse_dimacs_assignment.cc $(OBJ_OUT)$(OBJ_DIR)$Sparse_dimacs_assignment.$O

$(LIB_DIR)/$(LIBPREFIX)dimacs.$(DYNAMIC_LIB_SUFFIX): $(DIMACS_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)dimacs.$(DYNAMIC_LIB_SUFFIX) $(DIMACS_LIB_OBJS)

# FAP challenge problem format library

FAP_LIB_OBJS=\
	$(OBJ_DIR)/fap_model_printer.$O\
	$(OBJ_DIR)/fap_parser.$O\
	$(OBJ_DIR)/fap_utilities.$O

$(OBJ_DIR)/fap_model_printer.$O:$(EX_DIR)/cpp/fap_model_printer.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Sfap_model_printer.cc $(OBJ_OUT)$(OBJ_DIR)$Sfap_model_printer.$O
$(OBJ_DIR)/fap_parser.$O:$(EX_DIR)/cpp/fap_parser.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Sfap_parser.cc $(OBJ_OUT)$(OBJ_DIR)$Sfap_parser.$O
$(OBJ_DIR)/fap_utilities.$O:$(EX_DIR)/cpp/fap_utilities.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Sfap_utilities.cc $(OBJ_OUT)$(OBJ_DIR)$Sfap_utilities.$O

$(LIB_DIR)/$(LIBPREFIX)fap.$(DYNAMIC_LIB_SUFFIX): $(FAP_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)fap.$(DYNAMIC_LIB_SUFFIX) $(FAP_LIB_OBJS)

# Flatzinc code

FLATZINC_LIB_OBJS=\
	$(OBJ_DIR)/flatzinc/constraints.$O\
	$(OBJ_DIR)/flatzinc/flatzinc_constraints.$O\
	$(OBJ_DIR)/flatzinc/model.$O\
	$(OBJ_DIR)/flatzinc/parallel_support.$O\
	$(OBJ_DIR)/flatzinc/parser.$O\
	$(OBJ_DIR)/flatzinc/parser.tab.$O\
	$(OBJ_DIR)/flatzinc/parser.yy.$O\
	$(OBJ_DIR)/flatzinc/presolve.$O\
	$(OBJ_DIR)/flatzinc/sat_constraint.$O\
	$(OBJ_DIR)/flatzinc/search.$O\
	$(OBJ_DIR)/flatzinc/sequential_support.$O\
	$(OBJ_DIR)/flatzinc/solver.$O

$(GEN_DIR)/flatzinc/parser.yy.cc: $(SRC_DIR)/flatzinc/parser.lex $(FLEX)
	$(FLEX) -o$(GEN_DIR)/flatzinc/parser.yy.cc $(SRC_DIR)/flatzinc/parser.lex

$(GEN_DIR)/flatzinc/parser.tab.cc: $(SRC_DIR)/flatzinc/parser.yy $(BISON)
	$(BISON) -t -o $(GEN_DIR)/flatzinc/parser.tab.cc -d $<

$(GEN_DIR)/flatzinc/parser.tab.hh: $(GEN_DIR)/flatzinc/parser.tab.cc

$(OBJ_DIR)/flatzinc/constraints.$O:$(SRC_DIR)/flatzinc/constraints.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sconstraints.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sconstraints.$O

$(OBJ_DIR)/flatzinc/flatzinc_constraints.$O:$(SRC_DIR)/flatzinc/flatzinc_constraints.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sflatzinc_constraints.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sflatzinc_constraints.$O

$(OBJ_DIR)/flatzinc/model.$O:$(SRC_DIR)/flatzinc/model.cc $(SRC_DIR)/flatzinc/model.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Smodel.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Smodel.$O

$(OBJ_DIR)/flatzinc/parallel_support.$O:$(SRC_DIR)/flatzinc/parallel_support.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sparallel_support.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sparallel_support.$O

$(OBJ_DIR)/flatzinc/parser.$O:$(SRC_DIR)/flatzinc/parser.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/parser.h $(GEN_DIR)/flatzinc/parser.tab.hh
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sparser.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sparser.$O

$(OBJ_DIR)/flatzinc/parser.tab.$O:$(GEN_DIR)/flatzinc/parser.tab.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/parser.h $(GEN_DIR)/flatzinc/parser.tab.hh
	$(CCC) $(CFLAGS) -c $(GEN_DIR)$Sflatzinc$Sparser.tab.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sparser.tab.$O

$(OBJ_DIR)/flatzinc/parser.yy.$O:$(GEN_DIR)/flatzinc/parser.yy.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/parser.h $(GEN_DIR)/flatzinc/parser.tab.hh
	$(CCC) $(CFLAGS) -c $(GEN_DIR)$Sflatzinc$Sparser.yy.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sparser.yy.$O

$(OBJ_DIR)/flatzinc/presolve.$O:$(SRC_DIR)/flatzinc/presolve.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/presolve.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Spresolve.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Spresolve.$O

$(OBJ_DIR)/flatzinc/sat_constraint.$O:$(SRC_DIR)/flatzinc/sat_constraint.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h  $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Ssat_constraint.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Ssat_constraint.$O

$(OBJ_DIR)/flatzinc/search.$O:$(SRC_DIR)/flatzinc/search.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Ssearch.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Ssearch.$O

$(OBJ_DIR)/flatzinc/sequential_support.$O:$(SRC_DIR)/flatzinc/sequential_support.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Ssequential_support.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Ssequential_support.$O

$(OBJ_DIR)/flatzinc/solver.$O:$(SRC_DIR)/flatzinc/solver.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Ssolver.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Ssolver.$O

$(LIB_DIR)/$(LIBPREFIX)fz.$(STATIC_LIB_SUFFIX): $(FLATZINC_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)fz.$(STATIC_LIB_SUFFIX) $(FLATZINC_LIB_OBJS)

$(OBJ_DIR)/flatzinc/fz.$O:$(SRC_DIR)/flatzinc/fz.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sfz.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sfz.$O

$(OBJ_DIR)/flatzinc/parser_main.$O:$(SRC_DIR)/flatzinc/parser_main.cc $(SRC_DIR)/flatzinc/model.h $(SRC_DIR)/flatzinc/solver.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)$Sflatzinc$Sparser_main.cc $(OBJ_OUT)$(OBJ_DIR)$Sflatzinc$Sparser_main.$O

fz : $(BIN_DIR)/fz$E $(BIN_DIR)/parser_main$E

$(BIN_DIR)/fz$E: $(OBJ_DIR)/flatzinc/fz.$O $(STATIC_FLATZINC_DEPS)
	$(CCC) $(CFLAGS) $(OBJ_DIR)$Sflatzinc$Sfz.$O $(STATIC_FZ) $(STATIC_FLATZINC_LNK) $(STATIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sfz$E

$(BIN_DIR)/parser_main$E: $(OBJ_DIR)/flatzinc/parser_main.$O $(STATIC_FLATZINC_DEPS)
	$(CCC) $(CFLAGS) $(OBJ_DIR)$Sflatzinc$Sparser_main.$O $(STATIC_FZ) $(STATIC_FLATZINC_LNK) $(STATIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sparser_main$E

# Flow and linear assignment cpp

$(OBJ_DIR)/linear_assignment_api.$O:$(EX_DIR)/cpp/linear_assignment_api.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/linear_assignment_api.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_assignment_api.$O

$(BIN_DIR)/linear_assignment_api$E: $(DYNAMIC_GRAPH_DEPS) $(OBJ_DIR)/linear_assignment_api.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/linear_assignment_api.$O $(DYNAMIC_GRAPH_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Slinear_assignment_api$E

$(OBJ_DIR)/flow_api.$O:$(EX_DIR)/cpp/flow_api.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/flow_api.cc $(OBJ_OUT)$(OBJ_DIR)$Sflow_api.$O

$(BIN_DIR)/flow_api$E: $(DYNAMIC_GRAPH_DEPS) $(OBJ_DIR)/flow_api.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/flow_api.$O $(DYNAMIC_GRAPH_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sflow_api$E

$(OBJ_DIR)/dimacs_assignment.$O:$(EX_DIR)/cpp/dimacs_assignment.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/dimacs_assignment.cc $(OBJ_OUT)$(OBJ_DIR)$Sdimacs_assignment.$O

$(BIN_DIR)/dimacs_assignment$E: $(DYNAMIC_DIMACS_DEPS) $(OBJ_DIR)/dimacs_assignment.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/dimacs_assignment.$O $(DYNAMIC_DIMACS_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sdimacs_assignment$E

# Pure CP and Routing Examples

$(OBJ_DIR)/acp_challenge.$O:$(EX_DIR)/cpp/acp_challenge.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/acp_challenge.cc $(OBJ_OUT)$(OBJ_DIR)$Sacp_challenge.$O

$(BIN_DIR)/acp_challenge$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/acp_challenge.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/acp_challenge.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sacp_challenge$E

$(OBJ_DIR)/acp_challenge_routing.$O:$(EX_DIR)/cpp/acp_challenge_routing.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/acp_challenge_routing.cc $(OBJ_OUT)$(OBJ_DIR)$Sacp_challenge_routing.$O

$(BIN_DIR)/acp_challenge_routing$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/acp_challenge_routing.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/acp_challenge_routing.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sacp_challenge_routing$E

$(OBJ_DIR)/costas_array.$O: $(EX_DIR)/cpp/costas_array.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/costas_array.cc $(OBJ_OUT)$(OBJ_DIR)$Scostas_array.$O

$(BIN_DIR)/costas_array$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/costas_array.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/costas_array.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scostas_array$E

$(OBJ_DIR)/cryptarithm.$O:$(EX_DIR)/cpp/cryptarithm.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/cryptarithm.cc $(OBJ_OUT)$(OBJ_DIR)$Scryptarithm.$O

$(BIN_DIR)/cryptarithm$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/cryptarithm.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cryptarithm.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scryptarithm$E

$(OBJ_DIR)/cvrptw.$O: $(EX_DIR)/cpp/cvrptw.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/cvrptw.cc $(OBJ_OUT)$(OBJ_DIR)$Scvrptw.$O

$(BIN_DIR)/cvrptw$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/cvrptw.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cvrptw.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scvrptw$E

$(OBJ_DIR)/cvrptw_with_refueling.$O: $(EX_DIR)/cpp/cvrptw_with_refueling.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/cvrptw_with_refueling.cc $(OBJ_OUT)$(OBJ_DIR)$Scvrptw_with_refueling.$O

$(BIN_DIR)/cvrptw_with_refueling$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/cvrptw_with_refueling.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cvrptw_with_refueling.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scvrptw_with_refueling$E

$(OBJ_DIR)/cvrptw_with_resources.$O: $(EX_DIR)/cpp/cvrptw_with_resources.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/cvrptw_with_resources.cc $(OBJ_OUT)$(OBJ_DIR)$Scvrptw_with_resources.$O

$(BIN_DIR)/cvrptw_with_resources$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/cvrptw_with_resources.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cvrptw_with_resources.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scvrptw_with_resources$E

$(OBJ_DIR)/cvrptw_with_stop_times_and_resources.$O: $(EX_DIR)/cpp/cvrptw_with_stop_times_and_resources.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/cvrptw_with_stop_times_and_resources.cc $(OBJ_OUT)$(OBJ_DIR)$Scvrptw_with_stop_times_and_resources.$O

$(BIN_DIR)/cvrptw_with_stop_times_and_resources$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/cvrptw_with_stop_times_and_resources.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cvrptw_with_stop_times_and_resources.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Scvrptw_with_stop_times_and_resources$E

$(OBJ_DIR)/dobble_ls.$O:$(EX_DIR)/cpp/dobble_ls.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/dobble_ls.cc $(OBJ_OUT)$(OBJ_DIR)$Sdobble_ls.$O

$(BIN_DIR)/dobble_ls$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/dobble_ls.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/dobble_ls.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sdobble_ls$E

$(OBJ_DIR)/flexible_jobshop.$O:$(EX_DIR)/cpp/flexible_jobshop.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(EX_DIR)/cpp/flexible_jobshop.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/flexible_jobshop.cc $(OBJ_OUT)$(OBJ_DIR)$Sflexible_jobshop.$O

$(BIN_DIR)/flexible_jobshop$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/flexible_jobshop.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/flexible_jobshop.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sflexible_jobshop$E

$(OBJ_DIR)/golomb.$O:$(EX_DIR)/cpp/golomb.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/golomb.cc $(OBJ_OUT)$(OBJ_DIR)$Sgolomb.$O

$(BIN_DIR)/golomb$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/golomb.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/golomb.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sgolomb$E

$(OBJ_DIR)/jobshop.$O:$(EX_DIR)/cpp/jobshop.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/jobshop.cc $(OBJ_OUT)$(OBJ_DIR)$Sjobshop.$O

$(BIN_DIR)/jobshop$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/jobshop.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/jobshop.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sjobshop$E

$(OBJ_DIR)/jobshop_ls.$O:$(EX_DIR)/cpp/jobshop_ls.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/jobshop_ls.cc $(OBJ_OUT)$(OBJ_DIR)$Sjobshop_ls.$O

$(BIN_DIR)/jobshop_ls$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/jobshop_ls.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/jobshop_ls.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sjobshop_ls$E

$(OBJ_DIR)/jobshop_earlytardy.$O:$(EX_DIR)/cpp/jobshop_earlytardy.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(EX_DIR)/cpp/jobshop_earlytardy.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/jobshop_earlytardy.cc $(OBJ_OUT)$(OBJ_DIR)$Sjobshop_earlytardy.$O

$(BIN_DIR)/jobshop_earlytardy$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/jobshop_earlytardy.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/jobshop_earlytardy.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sjobshop_earlytardy$E

$(OBJ_DIR)/magic_square.$O:$(EX_DIR)/cpp/magic_square.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/magic_square.cc $(OBJ_OUT)$(OBJ_DIR)$Smagic_square.$O

$(BIN_DIR)/magic_square$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/magic_square.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/magic_square.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Smagic_square$E

$(OBJ_DIR)/model_util.$O:$(EX_DIR)/cpp/model_util.cc $(GEN_DIR)/constraint_solver/model.pb.h $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/model_util.cc $(OBJ_OUT)$(OBJ_DIR)$Smodel_util.$O

$(BIN_DIR)/model_util$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/model_util.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/model_util.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Smodel_util$E

$(OBJ_DIR)/multidim_knapsack.$O:$(EX_DIR)/cpp/multidim_knapsack.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/multidim_knapsack.cc $(OBJ_OUT)$(OBJ_DIR)$Smultidim_knapsack.$O

$(BIN_DIR)/multidim_knapsack$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/multidim_knapsack.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/multidim_knapsack.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Smultidim_knapsack$E

$(OBJ_DIR)/network_routing.$O:$(EX_DIR)/cpp/network_routing.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/network_routing.cc $(OBJ_OUT)$(OBJ_DIR)$Snetwork_routing.$O

$(BIN_DIR)/network_routing$E: $(DYNAMIC_CP_DEPS) $(DYNAMIC_GRAPH_DEPS) $(OBJ_DIR)/network_routing.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/network_routing.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_GRAPH_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Snetwork_routing$E

$(OBJ_DIR)/nqueens.$O: $(EX_DIR)/cpp/nqueens.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/nqueens.cc $(OBJ_OUT)$(OBJ_DIR)$Snqueens.$O

$(BIN_DIR)/nqueens$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/nqueens.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/nqueens.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Snqueens$E

$(OBJ_DIR)/nqueens2.$O: $(EX_DIR)/cpp/nqueens2.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/nqueens2.cc $(OBJ_OUT)$(OBJ_DIR)$Snqueens2.$O

$(BIN_DIR)/nqueens2$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/nqueens2.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/nqueens2.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Snqueens2$E

$(OBJ_DIR)/pdptw.$O: $(EX_DIR)/cpp/pdptw.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/pdptw.cc $(OBJ_OUT)$(OBJ_DIR)$Spdptw.$O

$(BIN_DIR)/pdptw$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/pdptw.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/pdptw.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Spdptw$E

$(OBJ_DIR)/sports_scheduling.$O:$(EX_DIR)/cpp/sports_scheduling.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/sports_scheduling.cc $(OBJ_OUT)$(OBJ_DIR)$Ssports_scheduling.$O

$(BIN_DIR)/sports_scheduling$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/sports_scheduling.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/sports_scheduling.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Ssports_scheduling$E

$(OBJ_DIR)/tsp.$O: $(EX_DIR)/cpp/tsp.cc $(SRC_DIR)/constraint_solver/constraint_solver.h $(SRC_DIR)/constraint_solver/routing.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/tsp.cc $(OBJ_OUT)$(OBJ_DIR)$Stsp.$O

$(BIN_DIR)/tsp$E: $(DYNAMIC_ROUTING_DEPS) $(OBJ_DIR)/tsp.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/tsp.$O $(DYNAMIC_ROUTING_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Stsp$E

# CP tests.

$(OBJ_DIR)/bug_pack.$O:$(EX_DIR)/tests/bug_pack.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/bug_pack.cc $(OBJ_OUT)$(OBJ_DIR)$Sbug_pack.$O

$(BIN_DIR)/bug_pack$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/bug_pack.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/bug_pack.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sbug_pack$E

$(OBJ_DIR)/bug_fz1.$O:$(EX_DIR)/tests/bug_fz1.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/bug_fz1.cc $(OBJ_OUT)$(OBJ_DIR)$Sbug_fz1.$O

$(BIN_DIR)/bug_fz1$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/bug_fz1.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/bug_fz1.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sbug_fz1$E

$(OBJ_DIR)/ac4r_table_test.$O:$(EX_DIR)/tests/ac4r_table_test.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/ac4r_table_test.cc $(OBJ_OUT)$(OBJ_DIR)$Sac4r_table_test.$O

$(BIN_DIR)/ac4r_table_test$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/ac4r_table_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/ac4r_table_test.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sac4r_table_test$E

$(OBJ_DIR)/gcc_test.$O:$(EX_DIR)/tests/gcc_test.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/gcc_test.cc $(OBJ_OUT)$(OBJ_DIR)$Sgcc_test.$O

$(BIN_DIR)/gcc_test$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/gcc_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/gcc_test.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sgcc_test$E

$(OBJ_DIR)/min_max_test.$O:$(EX_DIR)/tests/min_max_test.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/min_max_test.cc $(OBJ_OUT)$(OBJ_DIR)$Smin_max_test.$O

$(BIN_DIR)/min_max_test$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/min_max_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/min_max_test.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Smin_max_test$E

$(OBJ_DIR)/issue57.$O:$(EX_DIR)/tests/issue57.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/issue57.cc $(OBJ_OUT)$(OBJ_DIR)$Sissue57.$O

$(BIN_DIR)/issue57$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/issue57.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/issue57.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sissue57$E

$(OBJ_DIR)/visitor_test.$O:$(EX_DIR)/tests/visitor_test.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/visitor_test.cc $(OBJ_OUT)$(OBJ_DIR)$Svisitor_test.$O

$(BIN_DIR)/visitor_test$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/visitor_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/visitor_test.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Svisitor_test$E

$(OBJ_DIR)/boolean_test.$O:$(EX_DIR)/tests/boolean_test.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/boolean_test.cc $(OBJ_OUT)$(OBJ_DIR)$Sboolean_test.$O

$(BIN_DIR)/boolean_test$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/boolean_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/boolean_test.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sboolean_test$E

$(OBJ_DIR)/ls_api.$O:$(EX_DIR)/cpp/ls_api.cc $(SRC_DIR)/constraint_solver/constraint_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/ls_api.cc $(OBJ_OUT)$(OBJ_DIR)$Sls_api.$O

$(BIN_DIR)/ls_api$E: $(DYNAMIC_CP_DEPS) $(OBJ_DIR)/ls_api.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/ls_api.$O $(DYNAMIC_CP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sls_api$E

$(OBJ_DIR)/cpp11_test.$O:$(EX_DIR)/tests/cpp11_test.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Stests/cpp11_test.cc $(OBJ_OUT)$(OBJ_DIR)$Scpp11_test.$O

$(BIN_DIR)/cpp11_test$E: $(OBJ_DIR)/cpp11_test.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/cpp11_test.$O $(EXE_OUT)$(BIN_DIR)$Scpp11_test$E

# Frequency Assignment Problem

$(OBJ_DIR)/frequency_assignment_problem.$O:$(EX_DIR)/cpp/frequency_assignment_problem.cc
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/frequency_assignment_problem.cc $(OBJ_OUT)$(OBJ_DIR)$Sfrequency_assignment_problem.$O

$(BIN_DIR)/frequency_assignment_problem$E: $(DYNAMIC_FAP_DEPS) $(OBJ_DIR)/frequency_assignment_problem.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/frequency_assignment_problem.$O $(DYNAMIC_FAP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sfrequency_assignment_problem$E

# Linear Programming Examples

$(OBJ_DIR)/strawberry_fields_with_column_generation.$O: $(EX_DIR)/cpp/strawberry_fields_with_column_generation.cc $(SRC_DIR)/linear_solver/linear_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/strawberry_fields_with_column_generation.cc $(OBJ_OUT)$(OBJ_DIR)$Sstrawberry_fields_with_column_generation.$O

$(BIN_DIR)/strawberry_fields_with_column_generation$E: $(DYNAMIC_LP_DEPS) $(OBJ_DIR)/strawberry_fields_with_column_generation.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/strawberry_fields_with_column_generation.$O $(DYNAMIC_LP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sstrawberry_fields_with_column_generation$E

$(OBJ_DIR)/linear_programming.$O: $(EX_DIR)/cpp/linear_programming.cc $(SRC_DIR)/linear_solver/linear_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/linear_programming.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_programming.$O

$(BIN_DIR)/linear_programming$E: $(DYNAMIC_LP_DEPS) $(OBJ_DIR)/linear_programming.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/linear_programming.$O $(DYNAMIC_LP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Slinear_programming$E

$(OBJ_DIR)/linear_solver_protocol_buffers.$O: $(EX_DIR)/cpp/linear_solver_protocol_buffers.cc $(SRC_DIR)/linear_solver/linear_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/linear_solver_protocol_buffers.cc $(OBJ_OUT)$(OBJ_DIR)$Slinear_solver_protocol_buffers.$O

$(BIN_DIR)/linear_solver_protocol_buffers$E: $(DYNAMIC_LP_DEPS) $(OBJ_DIR)/linear_solver_protocol_buffers.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/linear_solver_protocol_buffers.$O $(DYNAMIC_LP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Slinear_solver_protocol_buffers$E

$(OBJ_DIR)/integer_programming.$O: $(EX_DIR)/cpp/integer_programming.cc $(SRC_DIR)/linear_solver/linear_solver.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp/integer_programming.cc $(OBJ_OUT)$(OBJ_DIR)$Sinteger_programming.$O

$(BIN_DIR)/integer_programming$E: $(DYNAMIC_LP_DEPS) $(OBJ_DIR)/integer_programming.$O
	$(CCC) $(CFLAGS) $(OBJ_DIR)/integer_programming.$O $(DYNAMIC_LP_LNK) $(DYNAMIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Sinteger_programming$E

# Sat solver

sat: bin/sat_runner$E

SAT_LIB_OBJS = \
	$(OBJ_DIR)/sat/boolean_problem.$O\
	$(OBJ_DIR)/sat/boolean_problem.pb.$O \
	$(OBJ_DIR)/sat/clause.$O\
	$(OBJ_DIR)/sat/encoding.$O\
	$(OBJ_DIR)/sat/lp_utils.$O\
	$(OBJ_DIR)/sat/optimization.$O\
	$(OBJ_DIR)/sat/pb_constraint.$O\
	$(OBJ_DIR)/sat/sat_parameters.pb.$O\
	$(OBJ_DIR)/sat/sat_solver.$O\
	$(OBJ_DIR)/sat/simplification.$O\
	$(OBJ_DIR)/sat/symmetry.$O\
	$(OBJ_DIR)/sat/unsat_proof.$O

satlibs: $(DYNAMIC_SAT_DEPS) $(STATIC_SAT_DEPS)

$(OBJ_DIR)/sat/sat_solver.$O: $(SRC_DIR)/sat/sat_solver.cc $(SRC_DIR)/sat/sat_solver.h $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/clause.h $(SRC_DIR)/sat/encoding.h $(SRC_DIR)/sat/unsat_proof.h $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/sat_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Ssat_solver.$O

$(OBJ_DIR)/sat/lp_utils.$O: $(SRC_DIR)/sat/lp_utils.cc $(SRC_DIR)/sat/lp_utils.h $(SRC_DIR)/sat/sat_solver.h $(GEN_DIR)/sat/sat_parameters.pb.h $(GEN_DIR)/glop/parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/lp_utils.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Slp_utils.$O

$(OBJ_DIR)/sat/simplification.$O: $(SRC_DIR)/sat/simplification.cc  $(SRC_DIR)/sat/simplification.h $(SRC_DIR)/sat/sat_base.h $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/simplification.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Ssimplification.$O

$(OBJ_DIR)/sat/boolean_problem.$O: $(SRC_DIR)/sat/boolean_problem.cc  $(SRC_DIR)/sat/boolean_problem.h $(GEN_DIR)/sat/boolean_problem.pb.h  $(SRC_DIR)/sat/sat_solver.h  $(SRC_DIR)/sat/sat_base.h $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/boolean_problem.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Sboolean_problem.$O

$(GEN_DIR)/sat/boolean_problem.pb.cc: $(SRC_DIR)/sat/boolean_problem.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/sat/boolean_problem.proto

$(GEN_DIR)/sat/boolean_problem.pb.h: $(GEN_DIR)/sat/boolean_problem.pb.cc

$(OBJ_DIR)/sat/boolean_problem.pb.$O: $(GEN_DIR)/sat/boolean_problem.pb.cc $(GEN_DIR)/sat/boolean_problem.pb.h
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/sat/boolean_problem.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Sboolean_problem.pb.$O

$(OBJ_DIR)/sat/clause.$O: $(SRC_DIR)/sat/clause.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/clause.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/clause.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Sclause.$O

$(OBJ_DIR)/sat/encoding.$O: $(SRC_DIR)/sat/encoding.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/encoding.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/encoding.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Sencoding.$O

$(OBJ_DIR)/sat/optimization.$O: $(SRC_DIR)/sat/optimization.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/clause.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/optimization.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Soptimization.$O

$(OBJ_DIR)/sat/pb_constraint.$O: $(SRC_DIR)/sat/pb_constraint.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/pb_constraint.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/pb_constraint.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Spb_constraint.$O

$(OBJ_DIR)/sat/unsat_proof.$O: $(SRC_DIR)/sat/unsat_proof.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/unsat_proof.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/unsat_proof.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Sunsat_proof.$O

$(OBJ_DIR)/sat/symmetry.$O: $(SRC_DIR)/sat/symmetry.cc $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/symmetry.h $(SRC_DIR)/sat/clause.h $(SRC_DIR)/sat/unsat_proof.h $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/sat/symmetry.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Ssymmetry.$O

$(GEN_DIR)/sat/sat_parameters.pb.cc: $(SRC_DIR)/sat/sat_parameters.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/sat/sat_parameters.proto

$(GEN_DIR)/sat/sat_parameters.pb.h: $(GEN_DIR)/sat/sat_parameters.pb.cc

$(OBJ_DIR)/sat/sat_parameters.pb.$O: $(GEN_DIR)/sat/sat_parameters.pb.cc $(GEN_DIR)/sat/sat_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/sat/sat_parameters.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Ssat_parameters.pb.$O

$(LIB_DIR)/$(LIBPREFIX)sat.$(DYNAMIC_LIB_SUFFIX): $(SAT_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)sat.$(DYNAMIC_LIB_SUFFIX) $(SAT_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)sat.$(STATIC_LIB_SUFFIX): $(SAT_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)sat.$(STATIC_LIB_SUFFIX) $(SAT_LIB_OBJS)
endif

$(OBJ_DIR)/sat/sat_runner.$O:$(EX_DIR)/cpp/sat_runner.cc $(SRC_DIR)/sat/sat_solver.h $(EX_DIR)/cpp/opb_reader.h $(EX_DIR)/cpp/sat_cnf_reader.h $(GEN_DIR)/sat/sat_parameters.pb.h  $(GEN_DIR)/sat/boolean_problem.pb.h  $(SRC_DIR)/sat/boolean_problem.h  $(SRC_DIR)/sat/sat_base.h $(SRC_DIR)/sat/simplification.h
	$(CCC) $(CFLAGS) -c $(EX_DIR)$Scpp$Ssat_runner.cc $(OBJ_OUT)$(OBJ_DIR)$Ssat$Ssat_runner.$O

$(BIN_DIR)/sat_runner$E: $(STATIC_SAT_DEPS) $(OBJ_DIR)/sat/sat_runner.$O
	$(CCC) $(CFLAGS) $(FZ_STATIC) $(OBJ_DIR)$Ssat$Ssat_runner.$O $(STATIC_SAT_LNK) $(STATIC_LD_FLAGS) $(EXE_OUT)$(BIN_DIR)$Ssat_runner$E

# Bop solver
BOP_LIB_OBJS = \
	$(OBJ_DIR)/bop/bop_base.$O\
	$(OBJ_DIR)/bop/bop_fs.$O\
	$(OBJ_DIR)/bop/bop_lns.$O\
	$(OBJ_DIR)/bop/bop_ls.$O\
	$(OBJ_DIR)/bop/bop_parameters.pb.$O\
	$(OBJ_DIR)/bop/bop_portfolio.$O\
	$(OBJ_DIR)/bop/bop_solution.$O\
	$(OBJ_DIR)/bop/bop_solver.$O\
	$(OBJ_DIR)/bop/bop_util.$O\
	$(OBJ_DIR)/bop/complete_optimizer.$O\
	$(OBJ_DIR)/bop/integral_solver.$O

boplibs: $(DYNAMIC_BOP_DEPS) $(STATIC_BOP_DEPS)

$(OBJ_DIR)/bop/bop_base.$O: $(SRC_DIR)/bop/bop_base.cc $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_base.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_base.$O

$(OBJ_DIR)/bop/bop_fs.$O: $(SRC_DIR)/bop/bop_fs.cc $(SRC_DIR)/bop/bop_fs.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_fs.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_fs.$O

$(OBJ_DIR)/bop/bop_lns.$O: $(SRC_DIR)/bop/bop_lns.cc $(SRC_DIR)/bop/bop_lns.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_lns.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_lns.$O

$(OBJ_DIR)/bop/bop_ls.$O: $(SRC_DIR)/bop/bop_ls.cc $(SRC_DIR)/bop/bop_ls.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_ls.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_ls.$O

$(GEN_DIR)/bop/bop_parameters.pb.cc: $(SRC_DIR)/bop/bop_parameters.proto
	$(PROTOBUF_DIR)/bin/protoc --proto_path=$(INC_DIR) --cpp_out=$(GEN_DIR) $(SRC_DIR)/bop/bop_parameters.proto

$(GEN_DIR)/bop/bop_parameters.pb.h: $(GEN_DIR)/bop/bop_parameters.pb.cc

$(OBJ_DIR)/bop/bop_parameters.pb.$O: $(GEN_DIR)/bop/bop_parameters.pb.cc $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(GEN_DIR)/bop/bop_parameters.pb.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_parameters.pb.$O

$(OBJ_DIR)/bop/bop_portfolio.$O: $(SRC_DIR)/bop/bop_portfolio.cc $(SRC_DIR)/bop/bop_portfolio.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_fs.h $(SRC_DIR)/bop/bop_ls.h $(SRC_DIR)/bop/bop_lns.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_portfolio.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_portfolio.$O

$(OBJ_DIR)/bop/bop_solver.$O: $(SRC_DIR)/bop/bop_solver.cc $(SRC_DIR)/bop/bop_solver.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_fs.h $(SRC_DIR)/bop/bop_ls.h $(SRC_DIR)/bop/bop_lns.h $(SRC_DIR)/bop/bop_portfolio.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_solver.$O

$(OBJ_DIR)/bop/bop_solution.$O: $(SRC_DIR)/bop/bop_solution.cc $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_solution.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_solution.$O

$(OBJ_DIR)/bop/bop_util.$O: $(SRC_DIR)/bop/bop_util.cc $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/bop_util.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sbop_util.$O

$(OBJ_DIR)/bop/complete_optimizer.$O: $(SRC_DIR)/bop/complete_optimizer.cc $(SRC_DIR)/bop/complete_optimizer.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/complete_optimizer.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Scomplete_optimizer.$O

$(OBJ_DIR)/bop/integral_solver.$O: $(SRC_DIR)/bop/integral_solver.cc $(SRC_DIR)/bop/integral_solver.h $(SRC_DIR)/bop/bop_solver.h $(SRC_DIR)/bop/bop_util.h $(SRC_DIR)/bop/bop_types.h $(SRC_DIR)/bop/bop_base.h $(SRC_DIR)/bop/bop_fs.h $(SRC_DIR)/bop/bop_ls.h $(SRC_DIR)/bop/bop_lns.h $(SRC_DIR)/bop/bop_portfolio.h $(SRC_DIR)/bop/bop_solution.h $(GEN_DIR)/bop/bop_parameters.pb.h
	$(CCC) $(CFLAGS) -c $(SRC_DIR)/bop/integral_solver.cc $(OBJ_OUT)$(OBJ_DIR)$Sbop$Sintegral_solver.$O

$(LIB_DIR)/$(LIBPREFIX)bop.$(DYNAMIC_LIB_SUFFIX): $(BOP_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) $(DYNAMIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)bop.$(DYNAMIC_LIB_SUFFIX) $(BOP_LIB_OBJS)

ifneq ($(SYSTEM),win)
$(LIB_DIR)/$(LIBPREFIX)bop.$(STATIC_LIB_SUFFIX): $(BOP_LIB_OBJS)
	$(STATIC_LINK_CMD) $(STATIC_LINK_PREFIX)$(LIB_DIR)$S$(LIBPREFIX)bop.$(STATIC_LIB_SUFFIX) $(BOP_LIB_OBJS)
endif

# OR Tools unique library.

$(LIB_DIR)/$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX): $(CONSTRAINT_SOLVER_LIB_OBJS) $(LINEAR_SOLVER_LIB_OBJS) $(UTIL_LIB_OBJS) $(GRAPH_LIB_OBJS) $(SHORTESTPATHS_LIB_OBJS) $(ROUTING_LIB_OBJS) $(BOP_LIB_OBJS) $(GLOP_LIB_OBJS) $(ALGORITHMS_LIB_OBJS) $(SPLIT_LIB_OBJS) $(SAT_LIB_OBJS) $(BASE_LIB_OBJS)
	$(DYNAMIC_LINK_CMD) \
	  $(LDOUT)$(LIB_DIR)$S$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX) \
	  $(ALGORITHMS_LIB_OBJS) \
	  $(SPLIT_LIB_OBJS) \
	  $(BASE_LIB_OBJS) \
	  $(CONSTRAINT_SOLVER_LIB_OBJS) \
	  $(GRAPH_LIB_OBJS) \
	  $(LINEAR_SOLVER_LIB_OBJS) \
	  $(BOP_LIB_OBJS) \
	  $(GLOP_LIB_OBJS) \
	  $(ROUTING_LIB_OBJS) \
	  $(SAT_LIB_OBJS) \
	  $(SHORTESTPATHS_LIB_OBJS) \
	  $(UTIL_LIB_OBJS) \
	  $(STATIC_LD_LP_DEPS) \
	  $(STATIC_LD_FLAGS)

# Target for archives

ifeq "$(SYSTEM)" "win"
cc_archive: $(LIB_DIR)/$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX)
	-$(DELREC) temp
	mkdir temp
	mkdir temp\\or-tools.$(PORT)
	mkdir temp\\or-tools.$(PORT)\\bin
	mkdir temp\\or-tools.$(PORT)\\examples
	mkdir temp\\or-tools.$(PORT)\\include
	mkdir temp\\or-tools.$(PORT)\\include\\algorithms
	mkdir temp\\or-tools.$(PORT)\\include\\base
	mkdir temp\\or-tools.$(PORT)\\include\\constraint_solver
	mkdir temp\\or-tools.$(PORT)\\include\\gflags
	mkdir temp\\or-tools.$(PORT)\\include\\glop
	mkdir temp\\or-tools.$(PORT)\\include\\google
	mkdir temp\\or-tools.$(PORT)\\include\\graph
	mkdir temp\\or-tools.$(PORT)\\include\\linear_solver
	mkdir temp\\or-tools.$(PORT)\\include\\util
	mkdir temp\\or-tools.$(PORT)\\lib
	mkdir temp\\or-tools.$(PORT)\\objs
	copy LICENSE-2.0.txt temp\\or-tools.$(PORT)
	copy tools\\README.cc temp\\or-tools.$(PORT)\\README
	copy tools\\Makefile.cc temp\\or-tools.$(PORT)\\Makefile
	copy lib\\ortools.lib temp\\or-tools.$(PORT)\\lib
	copy examples\\cpp\\*.cc temp\\or-tools.$(PORT)\\examples
	copy examples\\cpp\\*.h temp\\or-tools.$(PORT)\\examples
	copy src\\algorithms\\*.h temp\\or-tools.$(PORT)\\include\\algorithms
	copy src\\base\\*.h temp\\or-tools.$(PORT)\\include\\base
	copy src\\constraint_solver\\*.h temp\\or-tools.$(PORT)\\include\\constraint_solver
	copy src\\gen\\constraint_solver\\*.pb.h temp\\or-tools.$(PORT)\\include\\constraint_solver
	copy src\\graph\\*.h temp\\or-tools.$(PORT)\\include\\graph
	copy src\\bop\\*.h temp\\or-tools.$(PORT)\\include\\bop
	copy src\\gen\\bop\\*.pb.h temp\\or-tools.$(PORT)\\include\\bop
	copy src\\glop\\*.h temp\\or-tools.$(PORT)\\include\\glop
	copy src\\gen\\glop\\*.h temp\\or-tools.$(PORT)\\include\\glop
	copy src\\linear_solver\\*.h temp\\or-tools.$(PORT)\\include\\linear_solver
	copy src\\gen\\linear_solver\\*.pb.h temp\\or-tools.$(PORT)\\include\\linear_solver
	copy src\\sat\\*.h temp\\or-tools.$(PORT)\\include\\sat
	copy src\\gen\\sat\\*.pb.h temp\\or-tools.$(PORT)\\include\\sat
	copy src\\util\\*.h temp\\or-tools.$(PORT)\\include\\util
	cd temp\\or-tools.$(PORT)\\include && ..\..\..\tools\tar.exe -C ..\\..\\..\\dependencies\\install\\include -c -v gflags | ..\..\..\tools\tar.exe xvm
	cd temp\\or-tools.$(PORT)\\include && ..\..\..\tools\tar.exe -C ..\\..\\..\\dependencies\\install\\include -c -v google | ..\..\..\tools\tar.exe xvm
	cd temp\\or-tools.$(PORT)\\include && ..\..\..\tools\tar.exe -C ..\\..\\..\\dependencies\\install\\include -c -v sparsehash | ..\..\..\tools\tar.exe xvm
	cd temp && ..\tools\zip.exe -r ..\Google.OrTools.cc.$(PORT).$(GIT_REVISION).zip or-tools.$(PORT)
	-$(DELREC) temp
else
cc_archive: $(LIB_DIR)/$(LIBPREFIX)ortools.$(DYNAMIC_LIB_SUFFIX)
	-$(DELREC) temp
	mkdir temp
	mkdir temp/or-tools.$(PORT)
	mkdir temp/or-tools.$(PORT)/bin
	mkdir temp/or-tools.$(PORT)/examples
	mkdir temp/or-tools.$(PORT)/include
	mkdir temp/or-tools.$(PORT)/include/algorithms
	mkdir temp/or-tools.$(PORT)/include/base
	mkdir temp/or-tools.$(PORT)/include/constraint_solver
	mkdir temp/or-tools.$(PORT)/include/gflags
	mkdir temp/or-tools.$(PORT)/include/bop
	mkdir temp/or-tools.$(PORT)/include/glop
	mkdir temp/or-tools.$(PORT)/include/google
	mkdir temp/or-tools.$(PORT)/include/graph
	mkdir temp/or-tools.$(PORT)/include/linear_solver
	mkdir temp/or-tools.$(PORT)/include/sat
	mkdir temp/or-tools.$(PORT)/include/util
	mkdir temp/or-tools.$(PORT)/lib
	mkdir temp/or-tools.$(PORT)/objs
	cp LICENSE-2.0.txt temp/or-tools.$(PORT)
	cp tools/README.cc temp/or-tools.$(PORT)/README
	cp tools/Makefile.cc temp/or-tools.$(PORT)/Makefile
	cp lib/libortools.$(DYNAMIC_LIB_SUFFIX) temp/or-tools.$(PORT)/lib
ifeq ($(PLATFORM),MACOSX)
	cp tools/install_libortools_mac.sh temp/or-tools.$(PORT)
endif
	cp examples/cpp/*.cc temp/or-tools.$(PORT)/examples
	cp examples/cpp/*.h temp/or-tools.$(PORT)/examples
	cp src/algorithms/*.h temp/or-tools.$(PORT)/include/algorithms
	cp src/base/*.h temp/or-tools.$(PORT)/include/base
	cp src/constraint_solver/*.h temp/or-tools.$(PORT)/include/constraint_solver
	cp src/gen/constraint_solver/*.pb.h temp/or-tools.$(PORT)/include/constraint_solver
	cp src/bop/*.h temp/or-tools.$(PORT)/include/bop
	cp src/gen/bop/*.pb.h temp/or-tools.$(PORT)/include/bop
	cp src/glop/*.h temp/or-tools.$(PORT)/include/glop
	cp src/gen/glop/*.pb.h temp/or-tools.$(PORT)/include/glop
	cp src/graph/*.h temp/or-tools.$(PORT)/include/graph
	cp src/linear_solver/*.h temp/or-tools.$(PORT)/include/linear_solver
	cp src/gen/linear_solver/*.pb.h temp/or-tools.$(PORT)/include/linear_solver
	cp src/sat/*.h temp/or-tools.$(PORT)/include/sat
	cp src/gen/sat/*.pb.h temp/or-tools.$(PORT)/include/sat
	cp src/util/*.h temp/or-tools.$(PORT)/include/util
	cd temp/or-tools.$(PORT)/include && tar -C ../../../dependencies/install/include -c -v gflags | tar xvm
	cd temp/or-tools.$(PORT)/include && tar -C ../../../dependencies/install/include -c -v google | tar xvm
	cd temp/or-tools.$(PORT)/include && tar -C ../../../dependencies/install/include -c -v sparsehash | tar xvm
	cd temp && tar cvzf ../Google.OrTools.cc.$(PORT).$(GIT_REVISION).tar.gz or-tools.$(PORT)
	-$(DELREC) temp
endif

# Debug
printdir:
	@echo LIB_DIR = $(LIB_DIR)
	@echo BIN_DIR = $(BIN_DIR)
	@echo GEN_DIR = $(GEN_DIR)
	@echo OBJ_DIR = $(OBJ_DIR)
	@echo SRC_DIR = $(SRC_DIR)
	@echo EX_DIR  = $(EX_DIR)
